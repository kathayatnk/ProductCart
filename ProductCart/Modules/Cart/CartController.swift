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
    
    private lazy var reloadButton: UIBarButtonItem = {
        let reloadImage = UIImage(systemName: "arrow.counterclockwise")
        let barButtonItem = UIBarButtonItem(image: reloadImage, style: .plain, target: self, action: #selector(reload))
        barButtonItem.tintColor = .black
        return barButtonItem
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.setInitialState()
        viewModel.getCartItems()
        navigationItem.rightBarButtonItem = reloadButton
    }
    
    override func setupUI() {
        screenView.tableView.register(CartItemCell.self)
        screenView.tableView.register(EmptyTableViewCell.self)
        screenView.tableView.register(LoadingTableViewCell.self)
        screenView.tableView.registerHeaderFooter(UserInfoHeaderView.self)
        screenView.tableView.delegate = self
        screenView.tableView.dataSource = self
    }
    
    @objc private func reload() {
        viewModel.setInitialState()
        viewModel.getCartItems()
    }
    
    override func observeEvents() {
        
        viewModel.dataFetched.sink { [weak self] _ in
            guard let self = self else { return }
            self.checkState()
        }.store(in: &viewModel.cancellables)
        
        screenView.checkoutView.checkoutButton.publisher(for: .touchUpInside).sink { [weak self] _ in
            guard let self = self else { return }
            self.viewModel.routeTrigger.send(CartRoute.checkout)
        }.store(in: &viewModel.cancellables)
        
    }
    
    private func checkState() {
        switch viewModel.infoModel.state {
        case .initial:
            self.screenView.checkoutView.isHidden = true
        case .failed:
            self.screenView.checkoutView.isHidden = true
        case .result:
            self.screenView.checkoutView.isHidden = false
            self.updateCheckoutView()
        }
        self.screenView.tableView.reloadData()
    }
    
    private func updateCheckoutView() {
        self.screenView.checkoutView.update(with: viewModel.infoModel.data)
    }
}

// MARK: - TableView Delegates And DataSource Conformance
extension CartController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard section == 1 else { return 0 }
        switch viewModel.infoModel.state {
        case .initial, .failed:
            return 1
        case .result:
            return viewModel.infoModel.data.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch viewModel.infoModel.state {
        case .initial:
            let cell = tableView.dequeue(LoadingTableViewCell.self, indexPath: indexPath)
            return cell
        case .failed(let errorModel):
            let cell = tableView.dequeue(EmptyTableViewCell.self, indexPath: indexPath)
            cell.create(with: errorModel)
            return cell
        case .result:
            let cell = tableView.dequeue(CartItemCell.self, indexPath: indexPath)
            cell.create(with: viewModel.infoModel.data[indexPath.row])
            observeEvents(on: cell, at: indexPath)
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch viewModel.infoModel.state {
        case .initial, .failed:
            return tableView.bounds.height - 100.0 // on assumption we just removing 100 points from height
        case .result:
            return UITableView.automaticDimension
        }
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        guard section == 0 else { return 35.0 }
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        if section == 0 {
            guard let headerView = tableView.dequeueReusableHeaderFooterView(withIdentifier: UserInfoHeaderView.identifier) as? UserInfoHeaderView, let user = viewModel.infoModel.user else {
                return nil
            }
            
            headerView.userInfoView.detailButton.publisher(for: .touchUpInside).sink { [weak self] _ in
                guard let self = self else { return }
                self.viewModel.routeTrigger.send(CartRoute.userDetails(user))
            }.store(in: &viewModel.cancellables)
            
            headerView.create(for: user)
            return headerView
        } else {
            let orderView = UIView(frame: CGRect(x: 0, y: 0, width: tableView.bounds.width, height: 35.0))
            let orderLabel = UILabel(frame: CGRect(x: 15.0, y: 0, width: orderView.bounds.width - 30.0, height: 35.0))
            orderView.addSubview(orderLabel)
            orderLabel.attributedText = "Orders".attributed(font: .boldSystemFont(ofSize: 18.0), color: .darkGray)
            return orderView
        }
    }
    
    private func observeEvents(on cell: CartItemCell, at indexPath: IndexPath) {
        
        cell.cellView.quantityEditorView.plusButton.publisher(for: .touchUpInside).sink { [weak self] _ in
            guard let self = self else { return }
            self.viewModel.updateCount(at: indexPath)
            self.screenView.tableView.reloadRows(at: [indexPath], with: .automatic)
            self.updateCheckoutView()
        }.store(in: &cell.bag)
        
        cell.cellView.quantityEditorView.minusButton.publisher(for: .touchUpInside).sink { [weak self] _ in
            guard let self = self else { return }
            self.viewModel.updateCount(at: indexPath, decrease: true)
            self.screenView.tableView.reloadRows(at: [indexPath], with: .automatic)
            self.updateCheckoutView()
        }.store(in: &cell.bag)
    }
    
    func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle {
        return .none
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        
        switch viewModel.infoModel.state {
        case .initial, .failed:
            return nil
        case .result:
            let trash = UIContextualAction(style: .destructive, title: "Remove") { [weak self] (_, _, completionHandler) in
                guard let self = self else { return }
                self.remove(for: tableView, at: indexPath)
                completionHandler(true)
            }
            trash.backgroundColor = .systemRed
            let configuration = UISwipeActionsConfiguration(actions: [trash])
            configuration.performsFirstActionWithFullSwipe = false
            return configuration
        }
    }
    
    private func remove(for tableView: UITableView, at indexPath: IndexPath) {
        let allRemoved = self.viewModel.remove(at: indexPath)
        if allRemoved {
            screenView.checkoutView.isHidden = true
            tableView.reloadData()
        } else {
            tableView.deleteRows(at: [indexPath], with: .automatic)
            self.updateCheckoutView()
        }
    }
}
