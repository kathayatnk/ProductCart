//
//  CartItemCellViewModel.swift
//  ProductCart
//
//  Created by Narendra Kathayat on 18.03.22.
//

import Foundation

final class CartItemCellViewModel: BaseViewModel {
    
    private var imageLoadInProgress = false
    var imageData: Data?
    var imageLoadComplete:((Data?) -> Void)?
    var item: CartItem
    
    init(item: CartItem) {
        self.item = item
        super.init()
        self.startLoadingImage()
    }
    
    private func startLoadingImage() {
        guard !imageLoadInProgress, imageData == nil, let url = URL(string: item.product.image) else { return }
        imageLoadInProgress = true
        DispatchQueue.global(qos: .userInteractive).async { [weak self] in
            guard let self = self else { return }
            do {
                let data = try Data(contentsOf: url)
                self.notify(data: data)
            } catch {
                debugPrint("Failed to load image data from url \(url)")
                self.notify(data: nil)
            }
        }
    }
    
    private func notify(data: Data?) {
        self.imageData = data
        self.imageLoadComplete?(data)
        self.imageLoadInProgress = false
    }
}
