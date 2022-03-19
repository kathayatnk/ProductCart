//
//  AppCoordinator.swift
//  ProductCart
//
//  Created by Narendra on 16/03/2022.
//

import Foundation
import UIKit

final class AppCoordinator: BaseCoordinator {
    
    private let navigator: UINavigationController
    
    init(navigator: UINavigationController) {
        self.navigator = navigator
    }
    
    override func start() {
        showCart()
    }
    
    private func showCart() {
        let view = CartView()
        let viewModel = CartViewModel(
            cartManager: ManagerFactory.getCartManager(),
            userManager: ManagerFactory.getUserManager())
        let controller = CartController(baseView: view, baseViewModel: viewModel)
        controller.title = "My Cart"
        
        navigator.navigationBar.prefersLargeTitles = true
        navigator.setViewControllers([controller], animated: false)
    }
}
