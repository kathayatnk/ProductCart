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
        controller.title = Localized.myCart.value
        
        viewModel.routeTrigger.sink { [unowned self] route in
            switch route {
            case CartRoute.checkout:
                self.showCheckout()
            case CartRoute.userDetails(let user):
                self.showDetails(user: user)
            default:
                assertionFailure("Invalid or Unhandled route received")
                break
            }
        }.store(in: &viewModel.cancellables)
        
        navigator.navigationBar.prefersLargeTitles = true
        navigator.setViewControllers([controller], animated: false)
    }
    
    private func showDetails(user: User) {
        let view = UserDetailsView()
        let viewModel = UserDetailsViewModel()
        let controller = UserDetailsController(baseView: view, baseViewModel: viewModel)
        controller.title = "\(user.firstName) \(user.lastName)"
        
        let internalNavigator = UINavigationController(rootViewController: controller)
        navigator.present(internalNavigator, animated: true, completion: nil)
    }
    
    private func showCheckout() {
        let view = CheckoutView()
        let viewModel = CheckoutViewModel()
        let controller = CheckoutController(baseView: view, baseViewModel: viewModel)
        controller.title = Localized.payment.value
        
        let internalNavigator = UINavigationController(rootViewController: controller)
        navigator.present(internalNavigator, animated: true, completion: nil)
    }
}
