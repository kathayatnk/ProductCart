//
//  QuantityEditorView.swift
//  ProductCart
//
//  Created by Narendra Kathayat on 18.03.22.
//

import Foundation
import UIKit

final class QuantityEditorView: BaseView {
    
    lazy var minusButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("-", for: .normal)
        button.setTitleColor(.lightGray, for: .normal)
        button.backgroundColor = .offWhite
        button.layer.cornerRadius = 10.0
        button.layer.masksToBounds = true
        return button
    }()
    
    lazy var plusButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("+", for: .normal)
        button.backgroundColor = .black
        button.layer.cornerRadius = 10.0
        button.layer.masksToBounds = true
        return button
    }()
    
    lazy var quantityLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "1"
        label.textAlignment = .center
        return label
    }()
    
    lazy var containerStack: UIStackView = {
        let stackView = UIStackView()
        stackView.distribution = .fillEqually
        stackView.axis = .vertical
        stackView.spacing = 5.0
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    override func create() {
        
        addSubview(containerStack)
        
        NSLayoutConstraint.activate([
        
            containerStack.centerXAnchor.constraint(equalTo: centerXAnchor),
            containerStack.widthAnchor.constraint(equalToConstant: 30.0),
            containerStack.topAnchor.constraint(equalTo: topAnchor),
            containerStack.bottomAnchor.constraint(equalTo: bottomAnchor),
        
        ])
        
        containerStack.addArrangedSubview(minusButton)
        containerStack.addArrangedSubview(quantityLabel)
        containerStack.addArrangedSubview(plusButton)
    }
}
