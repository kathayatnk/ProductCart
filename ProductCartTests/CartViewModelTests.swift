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
        
        viewModel.dataFetched.sink(receiveValue: { _ in
            expectation.fulfill()
        }).store(in: &viewModel.cancellables)
        
        viewModel.getCartItems()
        
        wait(for: [expectation], timeout: 5) // the time out is 5 here becuase we are delaying the load by 2 in viewmodel
        
        XCTAssertTrue(viewModel.infoModel.data.count == 2)
    }

}


// MARK: - Mocked Managers

class MockedCartManager: CartManageable {
    let cartItems = CurrentValueSubject<[CartItem], Never>([])
    
    
    func seedInitialData(force: Bool) {
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
