//
//  CartItemCell.swift
//  ProductCart
//
//  Created by Narendra Kathayat on 17.03.22.
//

import Foundation
import UIKit
import Combine

final class CartItemCell: UITableViewCell {
    
    var bag = Set<AnyCancellable>()
    
    lazy var cellView: CartItemCellView = {
        let view = CartItemCellView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .red
        return view
    }()
    
    override func prepareForReuse() {
        super.prepareForReuse()
        bag = Set<AnyCancellable>()
    }
    
    func create(with item: CartItem) {
//        loadView()
        
    }
    
    private func loadView() {
        contentView.addSubview(cellView)
        NSLayoutConstraint.activate([
            cellView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            cellView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            cellView.topAnchor.constraint(equalTo: contentView.topAnchor),
            cellView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            cellView.heightAnchor.constraint(equalToConstant: 80.0)
        ])
    }
}
