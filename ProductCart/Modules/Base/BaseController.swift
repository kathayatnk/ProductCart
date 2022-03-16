//
//  BaseController.swift
//  ProductCart
//
//  Created by Narendra on 16/03/2022.
//

import Foundation
import UIKit

/// Base View Controller class that will be inherited by all controllers in app
/// This controller will manage some of the most used and common functions in ViewController
class BaseController: UIViewController {
    
    let baseView: BaseView
    let baseViewModel: BaseViewModel
    
    private lazy var backButton: UIBarButtonItem = {
        let buttonItem = UIBarButtonItem(
            image: UIImage(systemName: "chevron.left"),
            style: .plain,
            target: self,
            action: #selector(didClickBackButton))
        return buttonItem
    }()
    
    init(baseView: BaseView, baseViewModel: BaseViewModel) {
        self.baseView = baseView
        self.baseViewModel = baseViewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("Not initialized as we won't be using coder in this project")
    }
    
    override func loadView() {
        super.loadView()
        view = baseView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
        observeEvents()
    }
    
    private func addBackButton() {
        guard let navigationController = navigationController, navigationController.viewControllers.count > 1 else { return }
        navigationItem.leftBarButtonItem = backButton
    }
    
   // MARK: Functions that needs to be override by child controllers
    
    /// Override this method to setup the UI elements
    func setupUI() {}
    
    /// Override this function to start observing events
    func observeEvents() {}
    
    // MARK: Common functionality methods
    @objc func didClickBackButton() {
        baseViewModel.routeTrigger.send(CommonRoute.pop)
    }
}



