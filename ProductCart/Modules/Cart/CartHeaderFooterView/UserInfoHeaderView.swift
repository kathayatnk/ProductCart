//
//  UserInfoHeaderView.swift
//  ProductCart
//
//  Created by Narendra Kathayat on 17.03.22.
//

import Foundation
import UIKit
import Combine

final class UserInfoHeaderView: UITableViewHeaderFooterView {
    
    var bag = Set<AnyCancellable>()
    
    override func prepareForReuse() {
        super.prepareForReuse()
        bag = Set<AnyCancellable>()
    }
    
    lazy var userInfoView: HeaderView = {
        let headerView = HeaderView()
        headerView.translatesAutoresizingMaskIntoConstraints = false
        headerView.layer.cornerRadius = 10.0
        return headerView
    }()
    
    func create(for user: User) {
        contentView.backgroundColor = .offWhite
        loadView()

        userInfoView.userNameLabel.attributedText = "\(user.firstName) \(user.lastName)".attributed(font: .boldSystemFont(ofSize: 16.0), color: .darkGray)

        var fullAddressInfo = user.address?.primary ?? ""
        if let secondary = user.address?.secondary {
            fullAddressInfo.append("\n\(secondary)")
        }
        fullAddressInfo.append("\n\(user.address?.contactNumber ?? "")")

        userInfoView.userAddressLabel.attributedText = fullAddressInfo.attributed(font: .systemFont(ofSize: 13.0), color: .gray)
    }
    
    private func loadView() {
        contentView.addSubview(userInfoView)
        NSLayoutConstraint.activate([
            userInfoView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 8.0),
            userInfoView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -8.0),
            userInfoView.topAnchor.constraint(equalTo: contentView.topAnchor),
            userInfoView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -8.0)
        ])
    }
}
