//  
//  CartView.swift
//  ProductCart
//
//  Created by Narendra on 16/03/2022.
//

import UIKit

final class CartView: BaseView {
    
    lazy var tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .grouped)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.automaticallyAdjustsScrollIndicatorInsets = false
        tableView.estimatedRowHeight = 100.0
        tableView.separatorStyle = .none
        tableView.rowHeight = UITableView.automaticDimension
        tableView.backgroundColor = .offWhite
        return tableView
    }()
    
    lazy var checkoutView: CheckoutView = {
        let view = CheckoutView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    lazy var containerStack: UIStackView = {
        let view = UIStackView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    override func create() {
        backgroundColor = .offWhite
        generateChildrens()
    }
}

extension CartView {
    private func generateChildrens() {
        addSubview(tableView)
        addSubview(containerStack)
        NSLayoutConstraint.activate([
            tableView.leadingAnchor.constraint(equalTo: leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: trailingAnchor),
            tableView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 10.0),
            
            containerStack.leadingAnchor.constraint(equalTo: leadingAnchor),
            containerStack.trailingAnchor.constraint(equalTo: trailingAnchor),
            containerStack.bottomAnchor.constraint(equalTo: bottomAnchor),
            containerStack.topAnchor.constraint(equalTo: tableView.bottomAnchor)
        ])
        
        containerStack.addArrangedSubview(checkoutView)
    }
}
