//
//  CartInfoModel.swift
//  ProductCart
//
//  Created by Narendra Kathayat on 17.03.22.
//

import Foundation

enum DataState {
    case initial, failed(DataErrorModel), result
}

struct CartInfoModel<Element> {
    let user: User?
    var data: Element
    var state: DataState
    
    init(user: User? = nil, data: Element, state: DataState = .initial) {
        self.user = user
        self.data = data
        self.state = state
    }
}



