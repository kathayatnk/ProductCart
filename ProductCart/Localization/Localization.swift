//
//  Localization.swift
//  ProductCart
//
//  Created by Narendra Kathayat on 18.03.22.
//

import Foundation

enum LocalizedKey: String {
    case appName = "APP_NAME"
    case emptyCartTitle = "EMPTY_CART_TITLE"
    case emptyCartMessage = "EMPTY_CART_MESSAGE"
    
    var value: String {
        return rawValue.localized()
    }
}
