//
//  MockedCache.swift
//  ProductCartTests
//
//  Created by Narendra on 16/03/2022.
//

import Foundation
@testable import ProductCart

class MockedCache: Cache {
    
    private var data: Data?
    
    func set(data: Data, for key: String) {
        self.data = data
    }
    
    func getData(for key: String) -> Data? {
        data
    }
    
    func remove(for key: String) {
        data = nil
    }
}
