//  
//  CartController.swift
//  ProductCart
//
//  Created by Narendra on 16/03/2022.
//

import UIKit

class CartController: BaseController {
    
    /// The view associated to the controller
    private lazy var screenView: CartView = {
        baseView as! CartView
    }()
    
    /// The ViewModel associated to the controller
    private lazy var viewModel: CartViewModel = {
        baseViewModel as! CartViewModel
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .red
    }
}
