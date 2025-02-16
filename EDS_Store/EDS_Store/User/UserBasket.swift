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
        currentBasket.append((product, count))
    }
}



