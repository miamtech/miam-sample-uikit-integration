//
//  DemoBasketService.swift
//  SampleMiamUIKitIntegration
//
//  Created by miam x didi on 18/12/2023.
//

import Foundation
import Combine
import miamCore

class DemoBasketService: BasketSubscriber, BasketPublisher {
    private var cancellable: AnyCancellable? // used to create stream between mealz basket & our own
    internal var initialValue: [SupplierProduct] // part of BasketSubscriber/BasketPublisher protocol
    
    init(initialBasketList: [PretendProduct]) {
        self.initialValue = [] // First, initialize all properties as [] so we can use pretendProductsToRetailerProducts
        
        if initialBasketList.count > 0 {
            // Now convert (safely) if we have products
            self.initialValue = pretendProductsToRetailerProducts(products: initialBasketList)
        }
    }
    
    func receive(event: [SupplierProduct]) {
        updateBasketFromExternalSource(products: event)
    }
    
    func onBasketUpdate(sendUpdateToSDK: @escaping ([SupplierProduct]) -> Void) {
        cancellable = PretendBasket.shared.$items.sink { receiveValue in
            `sendUpdateToSDK`(
                self.pretendProductsToRetailerProducts(products: receiveValue)
            )
        }
    }
    
    private func pretendProductsToRetailerProducts(
        products: [PretendProduct]
    ) -> [SupplierProduct] {
        return products.filter { $0.quantity > 0 }.map { product -> SupplierProduct in
            return SupplierProduct(
                id: product.id,
                quantity: Int32(product.quantity),
                name: product.name,
                productIdentifier: nil,
                imageURL: product.imageUrl
            )
        }
    }
    
    private func updateBasketFromExternalSource(products: [SupplierProduct]) {
        // we need to update the basket all at once, otherwise we will have issues with Mealz updating too frequently
        var basketCopy = PretendBasket.shared.items
        for product in products {
            // check if we already have the product to remove or update info
            if let productToUpdateIndex = PretendBasket.shared.items.firstIndex(where: { $0.id == product.id }) {
                if product.quantity == 0 { // we know an item is deleted if the qty is 0
                    if basketCopy.indices.contains(productToUpdateIndex) {
                        basketCopy.remove(at: productToUpdateIndex)
                    }
                } else {
                    let item = PretendBasket.shared.items[productToUpdateIndex]
                    basketCopy[productToUpdateIndex] = PretendProduct(
                        id: product.id,
                        name: product.name ?? item.name,
                        quantity: Int(product.quantity),
                        imageUrl: product.imageURL ?? item.imageUrl)
                }
            }
            else { // otherwise add it to the client basket
                let newProduct = PretendProduct(
                    id: product.id,
                    name: product.name ?? "product",
                    quantity: Int(product.quantity),
                    imageUrl: product.imageURL
                )
                basketCopy.append(newProduct)
            }
        }
        PretendBasket.shared.items = basketCopy // update your basket after all operations
    }
}
