//
//  CartManagerTests.swift
//  ProductCartTests
//
//  Created by Narendra on 16/03/2022.
//
import XCTest
@testable import ProductCart
import Combine

class CartManagerTests: XCTestCase {
    
    private var cache: Cache?
    private var cartManager: CartManageable?
    private var cancellable: AnyCancellable?
    
    override func setUp() {
        let cache = MockedCache()
        self.cache = cache
        cartManager = CartManager(cache: cache)
    }
    
    override func tearDown() {
        cartManager = nil
    }
    
    func testThatTheCartItemIsProperlyAddedToCart() {
        
        guard let cartManager = cartManager else {
            XCTAssert(false)
            return
        }
        
        
        let item1 = MockedData.getItem()
        let item2 = MockedData.getItem()
        let item3 = MockedData.getItem()
        
        XCTAssertTrue(cartManager.cartItems.value.count == 0)
        
        do {
            try cartManager.add(item1)
            try cartManager.add(item2)
            try cartManager.add(item3)
            
            let allItems = cartManager.get()
            XCTAssertTrue(allItems.count == 3)
        } catch {
            XCTAssert(false)
        }
    }
    
    func testThatTheDeletionOfItemWorks() {
        
        guard let cartManager = cartManager else {
            XCTAssert(false)
            return
        }
        
        let item1 = MockedData.getItem()
        let item2 = MockedData.getItem()
        let item3 = MockedData.getItem()
        
        do {
            try cartManager.add(item1)
            try cartManager.add(item2)
            try cartManager.add(item3)
            
            XCTAssertTrue(cartManager.cartItems.value.count == 3)
            
            _ = try cartManager.delete(item2)
            XCTAssertTrue(cartManager.cartItems.value.count == 2)
            
            _ = try cartManager.delete(item1)
            XCTAssertTrue(cartManager.cartItems.value.count == 1)
            
            _ = try cartManager.delete(item3)
            XCTAssertTrue(cartManager.cartItems.value.count == 0)
            
        } catch {
            XCTAssert(false)
        }
    }
    
    func testDeletingDeletedItemsThrows() {
        guard let cartManager = cartManager else {
            XCTAssert(false)
            return
        }
        
        let item1 = MockedData.getItem()
        let item2 = MockedData.getItem()
        let item3 = MockedData.getItem()
        
        do {
            try cartManager.add(item1)
            try cartManager.add(item2)
            try cartManager.add(item3)
            
            _ = try cartManager.delete(item2)
            _ = try cartManager.delete(item2)
            XCTAssert(false)
            
        } catch {
            XCTAssert(true)
        }
    }
    
    func testUpdatingAnItemProperlyUpdatesTheData() {
        guard let cartManager = cartManager else {
            XCTAssert(false)
            return
        }
        
        let expectaion = expectation(description: "The cart items are properly updated")
        
        var item1 = MockedData.getItem()
        var item2 = MockedData.getItem()
        
        let updatedNotes: Set<String> = ["Updated Note 1", "Updated Note 2"]
        let updatedQty: Set<Int>  = [2, 4]
        
        do {
            
            try cartManager.add(item1)
            try cartManager.add(item2)
            
            item1.note = updatedNotes[updatedNotes.index(updatedNotes.startIndex, offsetBy: 0)]
            item1.quantity = updatedQty[updatedQty.index(updatedQty.startIndex, offsetBy: 0)]
            
            
            item2.note = updatedNotes[updatedNotes.index(updatedNotes.startIndex, offsetBy: 1)]
            item2.quantity = updatedQty[updatedQty.index(updatedQty.startIndex, offsetBy: 1)]
            
            
            try cartManager.update(item2)
            try cartManager.update(item1)
            
            cancellable = cartManager.cartItems.sink { items in
                
                let newNotes = Set(items.compactMap({ $0.note }))
                let newQtys = Set(items.map({ $0.quantity }))
                
                let noteDiff = newNotes.symmetricDifference(updatedNotes)
                let qtyDiff = newQtys.symmetricDifference(updatedQty)
                
                XCTAssertTrue(noteDiff.isEmpty)
                XCTAssertTrue(qtyDiff.isEmpty)
                
                expectaion.fulfill()
                
            }
            
            wait(for: [expectaion], timeout: 1)
            
            
        } catch {
            XCTAssert(false)
        }
        
    }
}
