//
//  CheckoutView.swift
//  ProductCart
//
//  Created by Narendra Kathayat on 20.03.22.
//

import Foundation
import UIKit

final class CheckoutView: BaseView {
    
    lazy var placeholderLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        return label
    }()
    
    override func create() {
        super.create()
        
        let title = "Checkout View".attributed(font: .boldSystemFont(ofSize: 20.0), color: .darkGray, alignment: .center)
        let message = "\nCheckout view will be displayed here. Currently it is under development.😇".attributed(font: .systemFont(ofSize: 15.0), color: .lightGray, alignment: .center)
        title.append(message)
        placeholderLabel.attributedText = title
        
        addSubview(placeholderLabel)
        NSLayoutConstraint.activate([
            placeholderLabel.centerYAnchor.constraint(equalTo: centerYAnchor),
            placeholderLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
            placeholderLabel.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 0.8)
        ])
    }
}
