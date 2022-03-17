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
        let viewModel = CartViewModel(cartManager: CartManagerFactory.get())
        let controller = CartController(baseView: view, baseViewModel: viewModel)
        
//        viewModel.trigger.sink { [weak self] (route) in
//            guard let self = self else { return }
//            switch route {
//            default:
//                break
//            }
//        }.store(in: &viewModel.bag)
        
        navigator.setViewControllers([controller], animated: false)
    }
}
