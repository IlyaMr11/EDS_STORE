//
//  UserDataDecoder.swift
//  EDS_Store
//
//  Created by Илья Морозов on 20.02.2025.
//

import Foundation

class UserDataCoder {
    static func decode(data: [String: Any]) -> UserData? {
        let name = data["name"] as? String ?? ""
        let phone = data["phone"] as? String ?? ""
        let notify = data["notify"] as? Bool ?? false
        let address = data["address"] as? [String] ?? []
        let login = data["login"] as? String ?? ""

        let userData = UserData(login: login, name: name, purchase: [], phone: phone, address: address, notify: notify)
        return userData
    }
    
        
}
