//
//  ManagerFactory.swift
//  ProductCart
//
//  Created by Narendra Kathayat on 17.03.22.
//

import Foundation

// Factory pattern to create the required Manager
struct ManagerFactory {
    
    static func getCartManager() -> CartManageable {
        return CartManager(cache: CacheFactory.get())
    }
    
    static func getUserManager() -> UserManageable {
        let userManager = UserManager(cache: CacheFactory.get())
        userManager.seedLoggedInUser()
        return userManager
    }
}
