//
//  BaseViewModel.swift
//  ProductCart
//
//  Created by Narendra on 16/03/2022.
//

import Foundation
import Combine

class BaseViewModel {
    var cancellables = Set<AnyCancellable>()
    var routeTrigger = PassthroughSubject<AppRoutable, Never>()
}
