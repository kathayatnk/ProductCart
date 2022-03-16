//
//  User.swift
//  ProductCart
//
//  Created by Narendra on 16/03/2022.
//

import Foundation

struct User: Codable {
    let firstName: String
    let lastName: String
    let email: String
    let id: UUID
}
