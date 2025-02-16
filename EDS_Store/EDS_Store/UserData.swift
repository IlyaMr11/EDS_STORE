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
    var purchase: [(Product, Int, String)]
    var phone: String?
    var address: [String]? = []
    var notify: Bool?
}

