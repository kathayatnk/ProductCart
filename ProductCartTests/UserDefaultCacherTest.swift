//
//  UserDefaultCacherTest.swift
//  ProductCartTests
//
//  Created by Narendra on 16/03/2022.
//

import Foundation
import XCTest
@testable import ProductCart
import Combine

class UserDefaultCacherTests: XCTestCase {
    
    private var cache: Cache?
    
    override func setUp() {
        self.cache = UserDefaultCacher(userDefault: UserDefaults.standard)
    }
    
    override func tearDown() {
       cache = nil
    }
    
    func testThatCacherIsCachingAndRetrievingDataProperly() {
        let item = MockedData.getItem()
        do {
            
            let itemData = try JSONEncoder().encode(item)
            cache?.set(data: itemData, for: "Item")
            
            let savedItemData = cache?.getData(for: "Item")
            
            XCTAssertNotNil(savedItemData)
            
            if let savedItemData = savedItemData {
                let savedItem = try JSONDecoder().decode(CartItem.self, from: savedItemData)
                
                XCTAssertEqual(item.itemId, savedItem.itemId)
                XCTAssertEqual(item.quantity, savedItem.quantity)
                XCTAssertEqual(item.product, savedItem.product)
            }
            
        } catch {
            XCTAssert(false)
        }
    }
    
    func testThatCacherIsCachingDeletingAndRetrievingDataProperly() {
        let item = MockedData.getItem()
        do {
            
            let itemData = try JSONEncoder().encode(item)
            cache?.set(data: itemData, for: "Item")
            cache?.remove(for: "Item")
            let savedItemData = cache?.getData(for: "Item")
            XCTAssertNil(savedItemData)
        } catch {
            XCTAssert(false)
        }
    }
}
