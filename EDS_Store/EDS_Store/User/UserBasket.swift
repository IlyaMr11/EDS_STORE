//
//  UserBasket.swift
//  EDS_Store
//
//  Created by Илья Морозов on 20.01.2025.
//

import Foundation

class UserBasket {
    static let shared = UserBasket()
    
    private init() {}
    
    private(set) var currentBasket: [Position] = UserDefaultsBasket.shared.getData() 
    
    //MARK: - ADD PRODUCT
    func addProductToBasket(_ product: anyProduct, count: Int) {
        for i in 0..<currentBasket.count {
            let pr = currentBasket[i].product
            if pr.name == product.name {
                currentBasket[i].count += count
                return
            }
        }
        currentBasket.append(Position(product: product, count: count))
        updateBadge()
    }
    
    //MARK: - CHANGE VALUES
    func changeCount(index: Int, count: Int) {
        currentBasket[index].count = count
        updateBadge()
    }
    
    func deleteProduct(index: Int) {
        currentBasket.remove(at: index)
        updateBadge()
    }
    
    func removeData() {
        currentBasket = []
        updateBadge()
    }
    
    //MARK: - UPDATE BADGE VALUE
    func updateBadge() {
        AppCordinator.shared.updateBadgeValue(currentBasket.count)
    }
}



