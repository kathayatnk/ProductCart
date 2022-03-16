//
//  CartManageable.swift
//  ProductCart
//
//  Created by Narendra on 16/03/2022.
//

import Foundation
import Combine

protocol CartManageable {
    var cartItems: CurrentValueSubject<[CartItem], Never> { get }
    func add(_ item: CartItem) throws
    func delete(_ item: CartItem) throws -> Int
    func update(_ item: CartItem) throws
    func get() -> [CartItem]
}
