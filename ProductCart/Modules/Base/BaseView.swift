//
//  BaseView.swift
//  ProductCart
//
//  Created by Narendra on 16/03/2022.
//

import Foundation
import UIKit

class BaseView: UIView {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        create()
    }
    
    required init?(coder: NSCoder) {
        fatalError("Not initialized as we won't be using coder in this project")
    }
    
    func create() {
        backgroundColor = .white
    }
}
