//
//  PretendBasket.swift
//  SampleMiamUIKitIntegration
//
//  Created by didi on 25/10/2023.
//

import Foundation
import miamCore

class PretendBasket: ObservableObject {
    static let shared = PretendBasket(
        items: [
            PretendProduct(id: "970417", name: "Beurre doux U, 125", quantity: 1, price: 2.12, identifier: "id_970417", imageUrl: "https://www.coursesu.com/dw/image/v2/BBQX_PRD/on/demandware.static/-/Sites-digitalu-master-catalog/default/dwec5f37b0/3256224252139_A_970417_S01.png?sw=388&sh=388&sm=fit"),
            PretendProduct(id: "42851844", name: "Curry tradition en poudre DUCROS, 53g", quantity: 1, price: 3.40, identifier: "id_6511680", imageUrl: "https://mccormick.widen.net/content/vgtrna5yxy/original/3166291744645_curry_saveur_brute.png")
        ])
    @Published var items = [PretendProduct]()

    private init(items: [PretendProduct]) {
        self.items = items
    }
    
    func add(addedProduct: PretendProduct) {
        if let existingProductIndex = items.firstIndex(where: { $0.id.isEqual(addedProduct.id) }) {
            let product = items[existingProductIndex]
            product.quantity += 1
        } else {
            items.append(addedProduct)
        }
    }

    func remove(removedProductId: String) {
        guard let productIndex = items.firstIndex(where: { $0.id.isEqual(removedProductId) }) else {
            return
        }
        items.remove(at: productIndex)
    }

    func removeAll() {
        items.removeAll()
        Mealz.shared.basket.clear()
    }
}
