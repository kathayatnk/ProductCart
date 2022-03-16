//
//  AppError.swift
//  ProductCart
//
//  Created by Narendra on 16/03/2022.
//

import Foundation

struct AppError: LocalizedError {
    
    private let reason: String
    let code: Int
    
    init(reason: String, code: Int = 0) {
        self.reason = reason
        self.code = code
    }
    
    var errorDescription: String? {
        reason
    }
}
