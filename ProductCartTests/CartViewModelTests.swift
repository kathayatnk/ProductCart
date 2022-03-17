//
//  CartViewModelTests.swift
//  ProductCartTests
//
//  Created by Narendra Kathayat on 17.03.22.
//

import Foundation
import XCTest
@testable import ProductCart
import Combine

class CartViewModelTests: XCTestCase {
    
    private var cartViewModel: CartViewModel?

    override func setUp() {
        cartViewModel = CartViewModel(cartManager: MockedCartManager(), userManager: MockedUserManaer())
    }
    
    override func tearDown() {
        cartViewModel = nil
    }
    
    func testThatTheDataSourceIsProperlyBuildOnInitialSeed() {
        
        guard let viewModel = cartViewModel else {
            XCTAssert(false)
            return
        }
        
        let expectation = expectation(description: "Data source trigger has the data")
        
        viewModel.dataSource.sink(receiveValue: { info in
            expectation.fulfill()
        }).store(in: &viewModel.cancellables)
        
        wait(for: [expectation], timeout: 1)
        
        XCTAssertNotNil(viewModel.dataSource.value)
        XCTAssertTrue(viewModel.dataSource.value?.items.count == 2)
    }

}


// MARK: - Mocked Managers

class MockedCartManager: CartManageable {
    let cartItems = CurrentValueSubject<[CartItem], Never>([])
    
    
    func seedInitialData() {
        cartItems.send([MockedData.getItem(), MockedData.getItem()])
    }
    
    func add(_ item: CartItem) throws {
        
    }
    
    func delete(_ item: CartItem) throws -> Int {
        0
    }
    
    func update(_ item: CartItem) throws {
        
    }
    
    func get() -> [CartItem] {
        []
    }
}

class MockedUserManaer: UserManageable {
    func seedLoggedInUser() {
        
    }
    
    func currentLoggedInUser() -> User? {
        MockedData.getUser()
    }
}
