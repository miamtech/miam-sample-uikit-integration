//
//  PretendProduct.swift
//  SampleMiamUIKitIntegration
//
//  Created by didi on 25/10/2023.
//

import Foundation

public class PretendProduct: Identifiable {
    public var id: String
    var name: String
    var quantity: Int
    var price: Double?
    var identifier: String?
    var imageUrl: String?

    init (id: String, name: String, quantity: Int, price: Double? = nil, identifier: String? = nil, imageUrl: String? = nil) {
        self.id = id
        self.name = name
        self.quantity = quantity
        self.price = price
        self.identifier = identifier
        self.imageUrl = imageUrl
  }
}
