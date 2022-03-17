//
//  UserInfoHeaderView.swift
//  ProductCart
//
//  Created by Narendra Kathayat on 17.03.22.
//

import Foundation
import UIKit

final class UserInfoHeaderView: UITableViewHeaderFooterView {
    
    lazy var userInfoView: HeaderView = {
        let headerView = HeaderView()
        headerView.translatesAutoresizingMaskIntoConstraints = false
        return headerView
    }()
    
    func create(for user: User) {
        loadView()
        
        userInfoView.userNameLabel.text = "\(user.firstName) \(user.lastName)"
        
        var fullAddressInfo = user.address?.primary ?? ""
        if let secondary = user.address?.secondary {
            fullAddressInfo.append("\n\(secondary)")
        }
        fullAddressInfo.append("\n\(user.address?.contactNumber ?? "")")
        
        userInfoView.userAddressLabel.text = fullAddressInfo
    }
    
    private func loadView() {
        contentView.addSubview(userInfoView)
        NSLayoutConstraint.activate([
            userInfoView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            userInfoView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            userInfoView.topAnchor.constraint(equalTo: contentView.topAnchor),
            userInfoView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
        ])
    }
}
