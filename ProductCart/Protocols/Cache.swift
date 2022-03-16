//
//  Cache.swift
//  ProductCart
//
//  Created by Narendra on 16/03/2022.
//

import Foundation

protocol Cache {
    func set(data: Data, for key: String)
    func getData(for key: String) -> Data?
    func remove(for key: String)
}
