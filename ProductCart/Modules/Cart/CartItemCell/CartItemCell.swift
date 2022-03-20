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
        view.backgroundColor = .white
        view.layer.cornerRadius = 10.0
        view.layer.masksToBounds = true
        return view
    }()
    
    override func prepareForReuse() {
        super.prepareForReuse()
        bag = Set<AnyCancellable>()
    }
    
    func create(with viewModel: CartItemCellViewModel) {
        backgroundColor = .offWhite
        contentView.backgroundColor = .offWhite
        loadView()
        
        loadProductImage(viewModel)
        cellView.productTitleLabel.attributedText = viewModel.item.product.name.attributed(font: .boldSystemFont(ofSize: 15.0), color: .black)
        cellView.productItemNoteLabel.attributedText = (viewModel.item.note ?? "").attributed(font: .systemFont(ofSize: 13.0), color: .lightGray)
        cellView.productPriceLabel.attributedText = "Rs. \(viewModel.item.product.price)".attributed(font: .boldSystemFont(ofSize: 18.0), color: .purple)
        cellView.quantityEditorView.quantityLabel.attributedText = "\(viewModel.item.quantity)".attributed(font: .systemFont(ofSize: 13.0), color: .darkGray, alignment: .center)
        
        selectionStyle = .none
        
    }
    
    private func loadProductImage(_ viewModel: CartItemCellViewModel) {
        
        if let imageData = viewModel.imageData, let image = UIImage(data: imageData) {
            cellView.indicatorView.stopAnimating()
            cellView.productImageView.image = image
        } else {
            cellView.indicatorView.startAnimating()
            viewModel.imageLoadComplete = {[weak self]  imageData in
                guard let self = self, let imageData = imageData, let image = UIImage(data: imageData) else { return }
                DispatchQueue.main.async { [weak self] in
                    guard let self = self else { return }
                    self.cellView.indicatorView.stopAnimating()
                    self.cellView.productImageView.image = image
                }
            }
        }
    }
    
    private func loadView() {
        contentView.addSubview(cellView)
        NSLayoutConstraint.activate([
            cellView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 8.0),
            cellView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -8.0),
            cellView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8.0),
            cellView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -8.0),
            cellView.heightAnchor.constraint(equalToConstant: 100.0)
        ])
    }
}
