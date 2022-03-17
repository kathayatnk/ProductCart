//  
//  CartViewModel.swift
//  ProductCart
//
//  Created by Narendra on 16/03/2022.
//

import Foundation
import Combine

class CartViewModel: BaseViewModel {
    
    private let userManager: UserManageable
    private let cartManager: CartManageable
    let dataSource = CurrentValueSubject<CartInfoModel?, Never>(nil)
    
    init(cartManager: CartManageable, userManager: UserManageable) {
        self.cartManager = cartManager
        self.userManager = userManager
        super.init()
        self.seedInitialData()
    }
    
    /// We seed the required mocked data
    private func seedInitialData() {
        cartManager.seedInitialData()
        userManager.seedLoggedInUser()
        
        // after the data is seeded we get the data set our dataSource
        cartManager.cartItems.sink { [weak self] items in
            guard let self = self, let user = self.userManager.currentLoggedInUser() else { return }
            let cartModel = CartInfoModel(user: user, items: items)
            self.dataSource.send(cartModel)
        }.store(in: &cancellables)
    }
}
