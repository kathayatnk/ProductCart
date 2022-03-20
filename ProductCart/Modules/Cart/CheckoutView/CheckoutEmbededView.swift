//
//  CheckoutEmbededView.swift
//  ProductCart
//
//  Created by Narendra Kathayat on 18.03.22.
//

import Foundation
import UIKit

final class CheckoutEmbededView: BaseView {
    
    lazy var subtotalView: LeftRightLabelView = {
        let view = LeftRightLabelView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.leftLabel.text = Localized.subtotal.value
        view.rightLabel.text = "-"
        return view
    }()
    
    lazy var taxView: LeftRightLabelView = {
        let view = LeftRightLabelView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.leftLabel.text = Localized.tax("10").value
        view.rightLabel.text = "-"
        return view
    }()
    
    lazy var totalView: LeftRightLabelView = {
        let view = LeftRightLabelView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.leftLabel.text = Localized.total.value
        view.rightLabel.text = "-"
        return view
    }()
    
    lazy var containerStack: UIStackView = {
        let stackView = UIStackView()
        stackView.distribution = .fillEqually
        stackView.axis = .vertical
        stackView.spacing = 5.0
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    lazy var checkoutButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle(Localized.continuePayment.value, for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = .black
        button.layer.cornerRadius = 10.0
        button.layer.masksToBounds = true
        return button
    }()
    
    override func create() {
        super.create()
        generateChildrens()
    }
    
    func update(with viewModels: [CartItemCellViewModel]) {
        guard !viewModels.isEmpty else { return }
        
        let subtotal: Double = viewModels.reduce(0) { $0 + Double($1.item.quantity) * $1.item.product.price }
        let tax = subtotal * 0.1
        let total = subtotal + tax
        
        subtotalView.rightLabel.attributedText = "\(Localized.currencyUnit.value) \(subtotal.decimalFormatted())".attributed(font: .systemFont(ofSize: 14.0, weight: .heavy), color: .darkGray, alignment: .right)
        taxView.rightLabel.attributedText = "\(Localized.currencyUnit.value) \(tax.decimalFormatted())".attributed(font: .systemFont(ofSize: 14.0, weight: .heavy), color: .darkGray, alignment: .right)
        totalView.rightLabel.attributedText = "\(Localized.currencyUnit.value) \(total.decimalFormatted())".attributed(font: .systemFont(ofSize: 14.0, weight: .heavy), color: .darkGray, alignment: .right)
    }
}

extension CheckoutEmbededView {
    
    private func generateChildrens() {
        addSubview(containerStack)
        addSubview(checkoutButton)
        
        NSLayoutConstraint.activate([
            containerStack.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 8.0),
            containerStack.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -8.0),
            containerStack.topAnchor.constraint(equalTo: topAnchor, constant: 8.0),
            containerStack.bottomAnchor.constraint(equalTo: checkoutButton.topAnchor, constant: -15.0),
            
            checkoutButton.centerXAnchor.constraint(equalTo: centerXAnchor),
            checkoutButton.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 0.8),
            checkoutButton.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor, constant: -8.0),
            checkoutButton.heightAnchor.constraint(equalToConstant: 50.0)
        ])
        
        containerStack.addArrangedSubview(subtotalView)
        containerStack.addArrangedSubview(taxView)
        containerStack.addArrangedSubview(totalView)
    }
    
    override func draw(_ rect: CGRect) {
        super.draw(rect)
        
        layer.shadowColor = UIColor.darkGray.cgColor
        layer.shadowOffset = CGSize(width: 0, height: 1)
        layer.shadowRadius = 2.0
        layer.shadowOpacity = 0.2
    }
}
