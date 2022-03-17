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
    
    enum CodingKeys: String, CodingKey {
        case id
        case name
        case price
        case image
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        self.id = UUID()
        self.name = try container.decodeIfPresent(String.self, forKey: .name) ?? ""
        self.price = try container.decodeIfPresent(Double.self, forKey: .price) ?? 1.0
        self.image = try container.decodeIfPresent(String.self, forKey: .image) ?? ""
    }
    
    init( id: UUID ,name: String ,price: Double ,image: String) {
        self.id = id
        self.name = name
        self.price = price
        self.image = image
    }
    
    static func == (lhs: Product, rhs: Product) -> Bool {
        return lhs.id == rhs.id
    }
}
