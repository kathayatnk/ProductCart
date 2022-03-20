//
//  UserManageable.swift
//  ProductCart
//
//  Created by Narendra Kathayat on 17.03.22.
//

import Foundation

protocol UserManageable {
    func seedLoggedInUser()
    func currentLoggedInUser() -> User?
}
