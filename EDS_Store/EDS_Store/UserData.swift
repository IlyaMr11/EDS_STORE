//
//  UserData.swift
//  EDS_Store
//
//  Created by Илья Морозов on 27.11.2024.
//

import Foundation

struct UserData {
    var login: String
    var name: String?
    var purchase: [Purchase]
    var phone: String?
    var address: [String]? = []
    var notify: Bool?
}

struct Purchase {
    var product: Product
    var count: Int
    var date: Date
    var status: String
}
