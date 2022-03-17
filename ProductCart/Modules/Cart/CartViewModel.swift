//  
//  CartViewModel.swift
//  ProductCart
//
//  Created by Narendra on 16/03/2022.
//

import Foundation

class CartViewModel: BaseViewModel {
    
    let cartManager: CartManageable
    
    init(cartManager: CartManageable) {
        self.cartManager = cartManager
        super.init()
        self.seedInitialData()
    }
    
    /// Method to seed initial cart data
    private func seedInitialData() {
        guard let pathURL = Bundle.main.url(forResource: "SampleData", withExtension: "json") else {
            assertionFailure("Unable to find the required sample data file in bundle")
            return
        }
        do {
            let contentData = try Data(contentsOf: pathURL)
            let items = try JSONDecoder().decode([CartItem].self, from: contentData)
            try cartManager.seed(items)
        } catch {
            assertionFailure("Unable to seed data \(error.localizedDescription)")
        }
    }
    
}
