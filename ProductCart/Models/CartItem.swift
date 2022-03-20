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
    
    
    enum CodingKeys: String, CodingKey {
        case itemId = "MyCustomItemId"
        case quantity
        case product
        case note
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        self.itemId = try container.decodeIfPresent(UUID.self, forKey: .itemId) ?? UUID()
        self.quantity = try container.decodeIfPresent(Int.self, forKey: .quantity) ?? 1
        self.product = try container.decode(Product.self, forKey: .product)
        self.note = try container.decodeIfPresent(String.self, forKey: .note)
        
    }
    
    
    init(itemId: UUID ,quantity: Int ,product: Product ,note: String?) {
        self.itemId = itemId
        self.quantity = quantity
        self.product = product
        self.note = note
    }
    
    static func == (lhs: CartItem, rhs: CartItem) -> Bool {
        return lhs.itemId == rhs.itemId
    }
}
