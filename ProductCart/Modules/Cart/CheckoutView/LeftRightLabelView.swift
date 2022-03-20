//
//  LeftRightLabelView.swift
//  ProductCart
//
//  Created by Narendra Kathayat on 18.03.22.
//

import Foundation
import UIKit

final class LeftRightLabelView: BaseView {
    
    lazy var leftLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .boldSystemFont(ofSize: 15.0)
        return label
    }()
    
    lazy var rightLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 15.0)
        label.textAlignment = .right
        return label
    }()
    
    lazy var containerStack: UIStackView = {
        let stackView = UIStackView()
        stackView.distribution = .fillEqually
        stackView.axis = .horizontal
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    override func create() {
        generateChildrens()
    }
}

extension LeftRightLabelView {
    
    private func generateChildrens() {
        
        addSubview(containerStack)
        
        NSLayoutConstraint.activate([
            containerStack.leadingAnchor.constraint(equalTo: leadingAnchor),
            containerStack.trailingAnchor.constraint(equalTo: trailingAnchor),
            containerStack.topAnchor.constraint(equalTo: topAnchor),
            containerStack.bottomAnchor.constraint(equalTo: bottomAnchor),
        ])
        
        containerStack.addArrangedSubview(leftLabel)
        containerStack.addArrangedSubview(rightLabel)
    }
}
