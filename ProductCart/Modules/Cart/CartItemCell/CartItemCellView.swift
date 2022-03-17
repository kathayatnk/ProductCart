//
//  CartItemCellView.swift
//  ProductCart
//
//  Created by Narendra Kathayat on 17.03.22.
//

import Foundation
import UIKit

final class CartItemCellView: BaseView {
    
    lazy var productImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    lazy var productTitleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var productItemNoteLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var productPriceLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    override func create() {
        generateChildrens()
    }
}

extension CartItemCellView {
    
    private func generateChildrens() {
        
        NSLayoutConstraint.activate([
        
        ])
    }
}
