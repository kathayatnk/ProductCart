//
//  UserdefaultCacher.swift
//  ProductCart
//
//  Created by Narendra on 16/03/2022.
//

import Foundation

struct UserDefaultCacher: Cache {
    
    private let userDefault: UserDefaults
    
    init(userDefault: UserDefaults) {
        self.userDefault = userDefault
    }
    
    func set(data: Data, for key: String) {
        userDefault.set(data, forKey: key)
    }
    
    func getData(for key: String) -> Data? {
        userDefault.data(forKey: key)
    }
    
    func remove(for key: String) {
        userDefault.removeObject(forKey: key)
    }
}
