//  
//  CartViewModel.swift
//  ProductCart
//
//  Created by Narendra on 16/03/2022.
//

import Foundation
import Combine

class CartViewModel: BaseViewModel {
    
    private let userManager: UserManageable
    private let cartManager: CartManageable
    private(set) var infoModel: CartInfoModel<[CartItemCellViewModel]>
    
    // the cancellable to cancel the subscription
    private var itemSubscritpionCancellable: AnyCancellable?
    
    // publsiher to indicate data is fetched
    let dataFetched = PassthroughSubject<Bool, Never>()
    
    init(cartManager: CartManageable, userManager: UserManageable) {
        self.cartManager = cartManager
        self.userManager = userManager
        self.infoModel = CartInfoModel(data: [])
        super.init()
    }
    
    
    func setInitialState() {
        self.infoModel = CartInfoModel(user: userManager.currentLoggedInUser(), data: [], state: .initial)
        dataFetched.send(true)
    }
    
    /// This can be network request to get the cart items
    /// for now we will simulate the effect
    /// This is just simulating method  which delays the data load by 2 seconds 
    func getCartItems() {
    
        // 1. re-seed data if all items becames empty or is empty
        cartManager.seedInitialData(force: infoModel.data.isEmpty)
        
        // 2. subscribe to items from cart manager and wait for 2 minutes, once the data is received we cancel the subscription
        itemSubscritpionCancellable = cartManager.cartItems.delay(for: 2, scheduler: RunLoop.main).sink { [weak self] items in
            guard let self = self else { return }
            self.setInfoModel(with: items)
            self.itemSubscritpionCancellable?.cancel()
            self.itemSubscritpionCancellable = nil
            self.dataFetched.send(true)
        }
    }
    
    private func setInfoModel(with items: [CartItem]) {
        let cellViewModels = items.map({ CartItemCellViewModel(item: $0) })
        self.infoModel = CartInfoModel(user: userManager.currentLoggedInUser(), data: cellViewModels, state: .result)
    }
    
    private func setEmptyData() {
        let errorModel = DataErrorModel(icon: nil, title: LocalizedKey.emptyCartTitle.value, message: LocalizedKey.emptyCartMessage.value)
        self.infoModel = CartInfoModel<[CartItemCellViewModel]>(user: userManager.currentLoggedInUser(), data: [], state: .failed(errorModel))
    }
    
    func updateCount(at indexPath: IndexPath, decrease: Bool = false) {
        let itemToUpdate = infoModel.data[indexPath.row]
        guard !(itemToUpdate.item.quantity == 1 && decrease) else { return }
        
        let newCount = decrease ? itemToUpdate.item.quantity - 1 : itemToUpdate.item.quantity + 1
        itemToUpdate.item.quantity = newCount
        
        do {
            try cartManager.update(itemToUpdate.item)
        } catch {
            debugPrint("Failed to update quantity \(error.localizedDescription)")
        }
    }
    
    func remove(at indexPath: IndexPath) -> Bool {
        let removableItem = infoModel.data.remove(at: indexPath.row)
        let dataEmpty = infoModel.data.isEmpty
        if dataEmpty {
            setEmptyData()
        }
        do {
            _ = try cartManager.delete(removableItem.item)
        } catch {
            assertionFailure("failed to remove item \(error.localizedDescription)")
        }
        
        return dataEmpty
    }
}
