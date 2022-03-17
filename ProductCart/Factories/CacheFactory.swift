//
//  CacheFactory.swift
//  ProductCart
//
//  Created by Narendra on 16/03/2022.
//

import Foundation

// Factory pattern to create the required Cache
struct CacheFactory {
    
    static func get() -> Cache {
        UserDefaultCacher(userDefault: UserDefaults.standard)
    }
}
