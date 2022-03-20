//
//  Localization.swift
//  ProductCart
//
//  Created by Narendra Kathayat on 18.03.22.
//

import Foundation

enum Localized {
    case appName
    case emptyCartTitle
    case emptyCartMessage
    case payment
    case continuePayment
    case total
    case subtotal
    case tax(String)
    case currencyUnit
    case myCart
    
    private var key: String {
        switch self {
        case .appName:
            return "APP_NAME"
        case .emptyCartTitle:
            return "EMPTY_CART_TITLE"
        case .emptyCartMessage:
            return "EMPTY_CART_MESSAGE"
        case .payment:
            return "PAYMENT"
        case .continuePayment:
            return "CONTINUE_PAYMENT"
        case .total:
            return "TOTAL"
        case .subtotal:
            return "SUBTOTAL"
        case .tax:
            return "TAX"
        case .currencyUnit:
            return "CURRENCY_UNIT"
        case .myCart:
            return "MY_CART"
        }
    }
    
    var value: String {
        switch self {
        case .tax(let taxValue):
            return key.localized(params: [taxValue])
        default:
            return key.localized()
        }
    }
}
