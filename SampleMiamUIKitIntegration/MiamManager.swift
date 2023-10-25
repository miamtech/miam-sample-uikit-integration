//
//  MiamManager.swift
//  SampleMiamUIKitIntegration
//
//  Created by didi on 23/10/2023.
//

import Foundation
import miamCore
import MiamIOSFramework
import SwiftUI
import Combine

@available(iOS 14, *)
public class Categories: ObservableObject {
    @Published var categoriesList: [CatalogCategory]  = []
}

public class MiamManager: ObservableObject {
    public static let sharedInstance = MiamManager()
    private let availableStoreIdLists = ["454", "652"]
    private var cancelable: AnyCancellable?
    public let categories = Categories()

    @Published var isReady: Bool = false

    func isActiveOnStore() -> KotlinBoolean {
        return  KotlinBoolean(value: availableStoreIdLists.contains("35290"))
    }

    // need to be private
    private init() {
        //        let supplierKey = "ewoJInN1cHBsaWVyX2lkIjogIjE0IiwKCSJwbGF1c2libGVfZG9tYWluZSI6ICJtaWFtLnRlc3QiLAoJIm1pYW1fb3JpZ2luIjogIm1pYW0iLAoJIm9yaWdpbiI6ICJtaWFtIiwKCSJtaWFtX2Vudmlyb25tZW50IjogIlVBVCIsCiJob3N0IjoibWlhbS1zYW1wbGUiCn0="
        let supplierKey = "ewoJInN1cHBsaWVyX2lkIjogIjciLAoJInBsYXVzaWJsZV9kb21haW5lIjogIm1pYW0uY291cnNlc3UuYXBwIiwKCSJtaWFtX29yaWdpbiI6ICJjb3Vyc2VzdSIsCgkib3JpZ2luIjogIm1pYW0uY291cnNlc3UuYXBwIiwKCSJtaWFtX2Vudmlyb25tZW50IjogIlBST0QiCiJob3N0IjoiY29jbyIKfQ=="
       
        BasketHandlerInstance.shared.instance.setListenToRetailerBasket(func: initBasketListener)
        BasketHandlerInstance.shared.instance.setPushProductsToRetailerBasket(func: pushProductToBasket)
        BasketHandlerInstance.shared.instance.pushProductsToMiamBasket(retailerBasket: [])
        
        PointOfSaleHandler.shared.updateStoreId(storeId: "25910")
        ContextHandlerInstance.shared.instance
         .doInitMiam(base64_key: supplierKey)
        UserHandler.shared.updateUserId(userId: "test_\(UUID())")

        // resets grocery cart - good for testing, do NOT include on actual production
        BasketHandlerInstance.shared.instance.clear()

        AnalyticsInstance.shared.instance.setOnEventEmitted( onEventEmittedCallBack: {event in  print("event Miam \(event.eventType)  \(event.path)  \(event.props)")})
    }

    private func pretendProductsToRetailerProducts(
        products: [PretendProduct]
    ) -> [RetailerProduct] {
        return products.map {
            return RetailerProduct(
                retailerId: $0.id,
                quantity: Int32($0.quantity),
                name: $0.name,
                productIdentifier: nil
            )
        }
    }

    private func pushProductToBasket(products: [RetailerProduct]) {
        let productsAddedFromRecipe = retailerProductsToYourProducts(products: products)
        let initialProducts = PretendBasket.shared.items
        var finalProducts = initialProducts.compactMap { retailerProduct in updateProductQuantityIfNeeded(
                retailerProduct: retailerProduct,
                productsAddedFromRecipe: productsAddedFromRecipe)
        }
        productsAddedFromRecipe.forEach({ productAddedFromRecipe in
            if (!finalProducts.contains(where: { retailerProducts in retailerProducts.id == productAddedFromRecipe.id })) {
                finalProducts.append(productAddedFromRecipe)
            }
        })
        PretendBasket.shared.items = finalProducts
    }

    private func updateProductQuantityIfNeeded(
        retailerProduct: PretendProduct,
        productsAddedFromRecipe: [PretendProduct]
    ) -> PretendProduct? {
        let updatedProduct = productsAddedFromRecipe.first(
            where: { productFromRecipe in
                productFromRecipe.id.isEqual(retailerProduct.id)
            })
        if updatedProduct == nil {
            return retailerProduct
        }
        if updatedProduct!.quantity == 0 {
            return nil
        }
        retailerProduct.quantity = updatedProduct!.quantity
        return retailerProduct
    }

    private func retailerProductsToYourProducts(products: [RetailerProduct]) -> [PretendProduct] {
        return products.map {
            return   PretendProduct(
                id: $0.retailerId,
                name: "\(String(describing: $0.name))",
                quantity: Int($0.quantity)
            )
        }
    }

    private func initBasketListener() {
        cancelable = PretendBasket.shared.$items.sink { receiveValue in
            BasketHandlerInstance.shared.instance.pushProductsToMiamBasket(
                retailerBasket: self.pretendProductsToRetailerProducts(products: receiveValue)
            )
        }
    }
}

public class PretendProduct: Identifiable {
    public var id: String
    var name: String
    var quantity: Int
    var price: Double?
    var identifier: String?

    init (id: String, name: String, quantity: Int, price: Double, identifier: String) {
      self.id = id
      self.name = name
      self.quantity = quantity
      self.price = price
      self.identifier = identifier
  }

    init (id: String, name: String, quantity: Int) {
      self.id = id
      self.name = name
      self.quantity = quantity
      self.price = nil
      self.identifier = nil
  }
}

class PretendBasket: ObservableObject {
    static let shared = PretendBasket(
        items: [
            PretendProduct(id: "970417", name: "Beurre doux U, 125", quantity: 1, price: 2.12, identifier: "id_970417"),
            PretendProduct(id: "42851844", name: "Curry tradition en poudre DUCROS, 53g", quantity: 1, price: 3.40, identifier: "id_6511680")
        ])
    @Published var items = [PretendProduct]()

    private init(items: [PretendProduct]) {
        self.items = items
    }

    func removeAll() {
        items.removeAll()
        BasketHandlerInstance.shared.instance.clear()
    }
}
