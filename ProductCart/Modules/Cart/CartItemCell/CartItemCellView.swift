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
        imageView.layer.cornerRadius = 10.0
        imageView.layer.masksToBounds = true
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    
    lazy var productTitleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var quantityEditorView: QuantityEditorView = {
        let view = QuantityEditorView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
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
        super.create()
        generateChildrens()
    }
}

extension CartItemCellView {
    
    private func generateChildrens() {
        addSubview(productImageView)
        addSubview(productTitleLabel)
        addSubview(productItemNoteLabel)
        addSubview(productPriceLabel)
        addSubview(quantityEditorView)
        NSLayoutConstraint.activate([
            productImageView.topAnchor.constraint(equalTo: topAnchor, constant: 8.0),
            productImageView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 8.0),
            productImageView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -8.0),
            productImageView.widthAnchor.constraint(equalTo: productImageView.heightAnchor),
            
            productTitleLabel.leadingAnchor.constraint(equalTo: productImageView.trailingAnchor, constant: 8.0),
            productTitleLabel.topAnchor.constraint(equalTo: productImageView.topAnchor, constant: 8.0),
            productTitleLabel.trailingAnchor.constraint(equalTo: quantityEditorView.leadingAnchor, constant: -8.0),
            
            productItemNoteLabel.leadingAnchor.constraint(equalTo: productImageView.trailingAnchor, constant: 8.0),
            productItemNoteLabel.topAnchor.constraint(equalTo: productTitleLabel.bottomAnchor, constant: 3.0),
            productItemNoteLabel.trailingAnchor.constraint(equalTo: quantityEditorView.leadingAnchor, constant: -8.0),
            
            productPriceLabel.leadingAnchor.constraint(equalTo: productImageView.trailingAnchor, constant: 8.0),
            productPriceLabel.topAnchor.constraint(equalTo: productItemNoteLabel.bottomAnchor, constant: 3.0),
            productPriceLabel.bottomAnchor.constraint(equalTo: productImageView.bottomAnchor, constant: -8.0),
            productPriceLabel.trailingAnchor.constraint(equalTo: quantityEditorView.leadingAnchor, constant: -8.0),
            
            quantityEditorView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -8.0),
            quantityEditorView.topAnchor.constraint(equalTo: topAnchor, constant: 8.0),
            quantityEditorView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -8.0),
            quantityEditorView.widthAnchor.constraint(equalToConstant: 40.0)
            
        ])
    }
}
