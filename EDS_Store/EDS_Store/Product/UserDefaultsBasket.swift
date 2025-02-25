//
//  UserDefaultsBasket.swift
//  EDS_Store
//
//  Created by Илья Морозов on 21.02.2025.
//

import Foundation

class UserDefaultsBasket {
    static let shared = UserDefaultsBasket()
    
    private let defaults = UserDefaults.standard
    private let key = "basket"
    private init() {}
    
    func updateBasket() {
        let basket = UserBasket.shared.currentBasket
        if let data = try? JSONEncoder().encode(basket) {
            defaults.set(data, forKey: key)
        }
    }
    
    func getData() -> [Position] {
        if let basketData = defaults.data(forKey: key) {
            if let bag = try? JSONDecoder().decode([Position].self, from: basketData) {
                return bag
            }
        }
        return []
    }
    
    func clearBasket() {
        defaults.removeObject(forKey: key)
    }
}
