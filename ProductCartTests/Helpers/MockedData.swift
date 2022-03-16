//
//  MockedData.swift
//  ProductCartTests
//
//  Created by Narendra on 16/03/2022.
//

import Foundation
@testable import ProductCart

struct MockedData {
    
    static func getUser() -> User {
        User(firstName: "Narendra ", lastName: "Kathayat", email: "kathayatnk@outlook.com", id: UUID())
    }
    
    static func getProduct() -> Product {
        Product(id: UUID(), name: "Chapati", price: 10.0, image: "")
    }
    
    static func getItem() -> CartItem {
        CartItem(itemId: UUID(), quantity: 1, product: getProduct(), note: "Test Note")
    }
}
