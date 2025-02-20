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
        let p = data["purchase"] as? [[String: Any]] ?? [[:]]
        let address = data["address"] as? [String] ?? []
        let login = data["login"] as? String ?? ""
        
        var purchases = [(Product, Int, String)]()
        for complex in p {
            let status = complex["status"] as? String ?? ""
            let count = complex["count"] as? Int ?? 0
            let pr = complex["product"] as? [String: Any] ?? [:]
            let product = ProductDecoder.prodcutDecoder(pr)
            purchases.append((product, count, status))
        }
        
        let userData = UserData(login: login, name: name, purchase: purchases, phone: phone, address: address, notify: notify)
        return userData
    }
    
    static func encode(attr: DataAttrs) -> Any? {
        switch attr {
        case .name:
            return PersonData.shared.userData?.name
        case .phone:
            return PersonData.shared.userData?.phone
        case .notify:
            return PersonData.shared.userData?.notify
        case .address:
            return PersonData.shared.userData?.address
        case .history:
            guard let purchases = PersonData.shared.userData?.purchase else {
                return nil
            }
            
            var data = [(Product, Int, String)]()
            for p in purchases {
                if p.2 == "done" {
                    data.append(p)
                }
            }
            return data
        case .delivery:
            guard let purchases = PersonData.shared.userData?.purchase else {
                return nil
            }
            
            var data = [(Product, Int, String)]()
            for p in purchases {
                if p.2 == "on track" {
                    data.append(p)
                }
            }
            return data
        }
    }
}
