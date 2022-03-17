//
//  UserManager.swift
//  ProductCart
//
//  Created by Narendra Kathayat on 17.03.22.
//

import Foundation

final class UserManager: UserManageable {
    
    private let cacheKey = "CurrentLoggedInUser"
    private let cache: Cache
    
    init(cache: Cache) {
        self.cache = cache
    }
    
    func seedLoggedInUser() {
        let address = Address(primary: "ward 13, chinatown near Balaju mall. Kathmandu", secondary: nil, contactNumber: "+977 98XXXXXXXX")
        let user = User(firstName: "Narendra", lastName: "Kathayat", email: "kathayatnk@outlook.com", id: UUID(), address: address)
        do {
            let userData = try JSONEncoder().encode(user)
            cache.set(data: userData, for: cacheKey)
        } catch {
            debugPrint("Unable to seed the logged in user \(error.localizedDescription)")
        }
    }
    
    func currentLoggedInUser() -> User? {
        guard let userData = cache.getData(for: cacheKey) else { return nil }
        do {
            let user = try JSONDecoder().decode(User.self, from: userData)
            return user
        } catch {
            debugPrint("faiked to decode user from userData \(error.localizedDescription)")
        }
        return nil
    }
}
