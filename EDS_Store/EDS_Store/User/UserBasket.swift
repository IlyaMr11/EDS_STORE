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
    
    private(set) var currentBasket: [(Product, Int)] = []
    
    func addProductToBasket(_ product: Product, count: Int) {
        for i in 0..<currentBasket.count {
            let (p, c) = currentBasket[i]
            if p.name == product.name {
                currentBasket[i] = (p, c + count)
                return
            }
        }
        currentBasket.append((product, count))
    }
    
    func changeCount(index: Int, count: Int) {
        currentBasket[index].1 = count
    }
    
    func deleteProduct(index: Int) {
        currentBasket.remove(at: index)
    }
    
    func removeData() {
        currentBasket = []
    }
}



