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
    }
    
    override func setupUI() {
        screenView.tableView.register(CartItemCell.self)
        screenView.tableView.registerHeaderFooter(UserInfoHeaderView.self)
        screenView.tableView.delegate = self
        screenView.tableView.dataSource = self
    }
    
    override func observeEvents() {
        
        viewModel.dataSource.sink { [weak self] _ in
            guard let self = self else { return }
            self.screenView.tableView.reloadData()
        }.store(in: &viewModel.cancellables)
    }
}

// MARK: - TableView Delegates And DataSource Conformance
extension CartController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel.dataSource.value?.items.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: CartItemCell.identifier, for: indexPath) as? CartItemCell, let items = viewModel.dataSource.value?.items else {
            fatalError("We must make sure that the cell class is register properly and the items are set if this data source method is called.")
        }
        let currentItem = items[indexPath.row]
        cell.create(with: currentItem)
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        guard let headerView = tableView.dequeueReusableHeaderFooterView(withIdentifier: UserInfoHeaderView.identifier) as? UserInfoHeaderView, let user = viewModel.dataSource.value?.user else {
            return nil
        }
        headerView.create(for: user)
        return headerView
    }
}
