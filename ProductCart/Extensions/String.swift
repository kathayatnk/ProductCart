//
//  String.swift
//  ProductCart
//
//  Created by Narendra Kathayat on 17.03.22.
//

import Foundation
import UIKit

extension String {
    
    func attributed(font: UIFont = UIFont.systemFont(ofSize: 15.0), color: UIColor = .black, alignment: NSTextAlignment = .left) -> NSMutableAttributedString {
        
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.alignment = alignment
        
        var attributes = [NSAttributedString.Key: Any]()
        attributes[.font] = font
        attributes[.foregroundColor] = color
        attributes[.paragraphStyle] = paragraphStyle
        return NSMutableAttributedString(string: self, attributes: attributes)
    }
    
    func localized(tableName: String? = nil,
                       bundle: Bundle = .main,
                       value: String = "", comment: String = "",
                       params: [CVarArg] = []) -> String {
            let localizedValue = String(
                format: NSLocalizedString(self, tableName: tableName, bundle: bundle, value: value, comment: comment),
                arguments: params
            )
            return localizedValue
        }

}
