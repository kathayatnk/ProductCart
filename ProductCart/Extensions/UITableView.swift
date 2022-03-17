//
//  UITableView.swift
//  ProductCart
//
//  Created by Narendra Kathayat on 17.03.22.
//

import Foundation
import UIKit

extension UITableView {
    
    func register<C: UITableViewCell>(_ type: C.Type) {
        register(type.self, forCellReuseIdentifier: C.identifier)
    }
    
    func registerHeaderFooter<C: UITableViewHeaderFooterView>(_ type: C.Type) {
        register(type.self, forHeaderFooterViewReuseIdentifier: C.identifier)
    }
}
