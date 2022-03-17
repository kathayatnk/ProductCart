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
        return imageView
    }()
    
    override func create() {
        generateChildrens()
    }
}

extension HeaderView {
    
    private func generateChildrens() {
        addSubview(profileImageView)
        addSubview(userNameLabel)
        addSubview(userAddressLabel)
        addSubview(moreDetailIconImageView)
        NSLayoutConstraint.activate([
            moreDetailIconImageView.centerYAnchor.constraint(equalTo: centerYAnchor),
            moreDetailIconImageView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10.0),
            moreDetailIconImageView.heightAnchor.constraint(equalToConstant: 20.0),
            moreDetailIconImageView.widthAnchor.constraint(equalToConstant: 20.0),
            
            profileImageView.centerYAnchor.constraint(equalTo: centerYAnchor),
            profileImageView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10.0),
            profileImageView.heightAnchor.constraint(equalToConstant: 60.0),
            profileImageView.widthAnchor.constraint(equalToConstant: 60.0),
            
            userNameLabel.leadingAnchor.constraint(equalTo: profileImageView.trailingAnchor, constant: 8.0),
            userNameLabel.trailingAnchor.constraint(equalTo: moreDetailIconImageView.leadingAnchor, constant: -8.0),
            userNameLabel.topAnchor.constraint(equalTo: topAnchor, constant: 8.0),
            userNameLabel.heightAnchor.constraint(equalToConstant: 30.0),

            userAddressLabel.leadingAnchor.constraint(equalTo: userNameLabel.leadingAnchor),
            userAddressLabel.trailingAnchor.constraint(equalTo: userNameLabel.trailingAnchor),
            userAddressLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -8.0),
            userAddressLabel.topAnchor.constraint(equalTo: userNameLabel.bottomAnchor, constant: 8.0)
            
        ])
    }
}
