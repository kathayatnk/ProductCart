//
//  EmptyTableViewCell.swift
//  ProductCart
//
//  Created by Narendra Kathayat on 18.03.22.
//

import Foundation
import UIKit

final class EmptyTableViewCell: UITableViewCell {
    
    lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var messageLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        return label
    }()
    
    lazy var containerStack: UIStackView = {
        let view = UIStackView()
        view.axis = .vertical
        view.distribution = .fillProportionally
        view.spacing = 10.0
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    func create(with model: DataErrorModel) {
        generateChildrens()
        
        titleLabel.attributedText = model.title.attributed(font: .boldSystemFont(ofSize: 16.0), color: .black, alignment: .center)
        messageLabel.attributedText = model.message.attributed(font: .systemFont(ofSize: 16.0), color: .lightGray, alignment: .center)
        selectionStyle = .none
    }
    
    private func generateChildrens() {
        contentView.addSubview(containerStack)
        NSLayoutConstraint.activate([
            containerStack.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            containerStack.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            containerStack.widthAnchor.constraint(equalTo: contentView.widthAnchor, multiplier: 0.8)
        ])
        
        containerStack.addArrangedSubview(titleLabel)
        containerStack.addArrangedSubview(messageLabel)
    }
}
