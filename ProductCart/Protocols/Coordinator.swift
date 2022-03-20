//
//  Coordinator.swift
//  ProductCart
//
//  Created by Narendra on 16/03/2022.
//

import Foundation

protocol Coordinator: AnyObject {
    func start()
    func coordinate(to coordinator: Coordinator)
}
