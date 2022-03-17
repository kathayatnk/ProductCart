//  
//  CartView.swift
//  ProductCart
//
//  Created by Narendra on 16/03/2022.
//

import UIKit

final class CartView: BaseView {
    
    lazy var tableView: UITableView = {
        let tableView = UITableView(frame: .zero)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.automaticallyAdjustsScrollIndicatorInsets = false
        tableView.estimatedRowHeight = 100.0
        tableView.rowHeight = UITableView.automaticDimension
        return tableView
    }()
    
    override func create() {
        generateChildrens()
    }
}

extension CartView {
    private func generateChildrens() {
        addSubview(tableView)
        NSLayoutConstraint.activate([
            tableView.leadingAnchor.constraint(equalTo: leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: trailingAnchor),
            tableView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 10.0),
            tableView.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor)
        ])
    }
}
