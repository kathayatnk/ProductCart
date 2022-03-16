//
//  CartItem.swift
//  ProductCart
//
//  Created by Narendra on 16/03/2022.
//

import Foundation

struct CartItem: Codable, Equatable {
    let itemId: UUID
    var quantity: Int
    let product: Product
    var note: String?
    
    static func == (lhs: CartItem, rhs: CartItem) -> Bool {
        return lhs.itemId == rhs.itemId
    }
}
