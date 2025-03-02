//
//  UserDataConvertor.swift
//  EDS_Store
//
//  Created by Илья Морозов on 27.02.2025.
//

import Foundation

class UserDataConvertor {
    static func getData(attr: DataAttrs) -> Any? {
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
            
            var data = [Date: [Purchase]]()
            for p in purchases {
                if p.status == "done" {
                    data[p.date] = (data[p.date] ?? []) + [p]
                }
            }
            return data
            
        case .delivery:
            guard let purchases = PersonData.shared.userData?.purchase else {
                return nil
            }
            
            var data = [Date: [Purchase]]()
            for p in purchases {
                if p.status == "on track" {
                    data[p.date] = (data[p.date] ?? []) + [p]
                }
            }
            return data
        }
    }
}
