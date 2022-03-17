//
//  CartManagerFactory.swift
//  ProductCart
//
//  Created by Narendra on 16/03/2022.
//

import Foundation

// Factory pattern to create the required CartManager
struct CartManagerFactory {
    
    static func get() -> CartManageable {
        return CartManager(cache: CacheFactory.get())
    }
}
