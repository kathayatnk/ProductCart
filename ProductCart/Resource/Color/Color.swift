//
//  Color.swift
//  ProductCart
//
//  Created by Narendra Kathayat on 18.03.22.
//

import Foundation
import UIKit

extension UIColor {
    
    private static func color( _ name: String) -> UIColor {
        guard let color = UIColor(named: name) else { fatalError("The name \(name) of color cannot be found") }
        return color
    }
    
    static let navigationBarColor = color("NavigationBarColor")
    static let offWhite = color("OffWhite")
}
