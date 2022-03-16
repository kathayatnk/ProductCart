//
//  Product.swift
//  ProductCart
//
//  Created by Narendra on 16/03/2022.
//

import Foundation

struct Product: Codable, Equatable {
    let id: UUID
    let name: String
    let price: Double
    let image: String
    
    static func == (lhs: Product, rhs: Product) -> Bool {
        return lhs.id == rhs.id
    }
}
