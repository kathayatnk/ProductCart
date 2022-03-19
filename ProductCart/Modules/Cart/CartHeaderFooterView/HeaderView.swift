//
//  HeaderView.swift
//  ProductCart
//
//  Created by Narendra Kathayat on 17.03.22.
//

import Foundation
import UIKit

final class HeaderView: BaseView {
    
    lazy var profileImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFill
        imageView.image = .narendra
        return imageView
    }()
    
    lazy var userNameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var userAddressLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        return label
    }()
    
    lazy var moreDetailIconImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFill
        imageView.image = .chevronRight
        imageView.tintColor = .lightGray
        return imageView
    }()
    
    lazy var containerStack: UIStackView = {
        let stackView = UIStackView()
        stackView.distribution = .fillProportionally
        stackView.axis = .vertical
        stackView.spacing = 5.0
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    override func create() {
        super.create()
        generateChildrens()
    }
}

extension HeaderView {
    
    private func generateChildrens() {
        addSubview(profileImageView)
        addSubview(containerStack)
        addSubview(moreDetailIconImageView)
        NSLayoutConstraint.activate([
            moreDetailIconImageView.centerYAnchor.constraint(equalTo: centerYAnchor),
            moreDetailIconImageView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10.0),
            moreDetailIconImageView.heightAnchor.constraint(equalToConstant: 15.0),
            moreDetailIconImageView.widthAnchor.constraint(equalToConstant: 15.0),
            
            profileImageView.centerYAnchor.constraint(equalTo: centerYAnchor),
            profileImageView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10.0),
            profileImageView.heightAnchor.constraint(equalToConstant: 60.0),
            profileImageView.widthAnchor.constraint(equalToConstant: 60.0),
            
            containerStack.leadingAnchor.constraint(equalTo: profileImageView.trailingAnchor, constant: 15.0),
            containerStack.trailingAnchor.constraint(equalTo: moreDetailIconImageView.leadingAnchor, constant: -15.0),
            containerStack.topAnchor.constraint(equalTo: topAnchor, constant: 10.0),
            containerStack.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -10.0)
            
        ])
        
        containerStack.addArrangedSubview(userNameLabel)
        containerStack.addArrangedSubview(userAddressLabel)
    }
    
    override func draw(_ rect: CGRect) {
        super.draw(rect)
        
        profileImageView.layer.cornerRadius = profileImageView.bounds.height / 2.0
        profileImageView.layer.masksToBounds = true
    }
}
