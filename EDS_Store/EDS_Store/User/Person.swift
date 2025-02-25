//
//  Person.swift
//  EDS_Store
//
//  Created by Илья Морозов on 11.01.2025.
//

import Foundation

struct Person: Codable {
    var login: String
    var password: String
}

enum DataAttrs: String {
    case name = "name"
    case notify = "notify"
    case phone = "phone"
    case address = "address"
    case history = "history"
    case delivery = "delivery"
}

class PersonData {
    static let shared = PersonData()
    
    private(set) var userData: UserData?
    private(set) var currentUser: Person?
    private init() {}
    
    func setUser(_ person: Person?) {
        currentUser = person
    }
    
    func setUserData(_ userData: UserData?) {
        self.userData = userData
    }
    
    func setDataAttrs(attr: DataAttrs, newValue: Any) {
        switch attr {
        case .name: userData?.name = newValue as? String ?? ""
        case .phone: userData?.phone = newValue as? String ?? ""
        case .notify: userData?.notify = newValue as? Bool ?? false
        case .address: userData?.address = newValue as? [String] ?? []
        default: break
        }
    }
    
    func createOrder(address: String) {
        for position in UserBasket.shared.currentBasket {
            let product = position.product
            let count = position.count
            
            let newPurchase: Purchase = Purchase(
                product: product,
                count: count,
                date: Date(),
                status: "on track",
                address: address
            )
            userData?.purchase.append(newPurchase)
        }
    }
    
    func removeUser() {
        currentUser = nil
        userData = nil
    }
    
}


