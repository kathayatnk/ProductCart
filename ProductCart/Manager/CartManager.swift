//
//  CartManager.swift
//  ProductCart
//
//  Created by Narendra on 16/03/2022.
//

import Foundation
import Combine

final class CartManager: CartManageable {
    
    private let cacheKey = "CurrentCartItems"
    private let cache: Cache
    let cartItems = CurrentValueSubject<[CartItem], Never>([])
    
    init(cache: Cache) {
        self.cache = cache
        self.cartItems.send(get())
    }
    
    func add(_ item: CartItem) throws {
        
        var availableItems = cartItems.value
        availableItems.append(item)
        try updateCache(availableItems)
    }
    
    func delete(_ item: CartItem) throws -> Int {
        var availableItems = cartItems.value
        guard let index = availableItems.firstIndex(of: item) else {
            throw AppError(reason: "Item not available in cart")
        }
        availableItems.remove(at: index)
        try updateCache(availableItems)
        return index
    }
    
    func update(_ item: CartItem) throws {
        let index = try delete(item)
        var availableItems = cartItems.value
        availableItems.insert(item, at: index)
        
        try updateCache(availableItems)
    }
    
    func get() -> [CartItem] {
        guard let cartItemData = cache.getData(for: cacheKey) else { return [] }
        do {
            let items = try JSONDecoder().decode([CartItem].self, from: cartItemData)
            return items
        } catch {
            return []
        }
    }
    
    func seed(_ items: [CartItem]) throws {
        try updateCache(items)
    }
    
    private func updateCache(_ items: [CartItem]) throws {
        
        let data = try JSONEncoder().encode(items)
        cache.set(data: data, for: cacheKey)
        
        cartItems.send(items)
    }
}
