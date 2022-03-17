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
    
    func seedInitialData() {
        guard let pathURL = Bundle.main.url(forResource: "SampleData", withExtension: "json") else {
            assertionFailure("Unable to find the required sample data file in bundle")
            return
        }
        do {
            let contentData = try Data(contentsOf: pathURL)
            let items = try JSONDecoder().decode([CartItem].self, from: contentData)
            try updateCache(items)
        } catch {
            assertionFailure("Unable to seed data \(error.localizedDescription)")
        }
    }
    
    private func updateCache(_ items: [CartItem]) throws {
        
        let data = try JSONEncoder().encode(items)
        cache.set(data: data, for: cacheKey)
        
        cartItems.send(items)
    }
}
