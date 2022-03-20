//
//  Address.swift
//  ProductCart
//
//  Created by Narendra Kathayat on 17.03.22.
//

import Foundation

struct Address: Codable {
    let primary: String
    let secondary: String?
    let contactNumber: String
}
