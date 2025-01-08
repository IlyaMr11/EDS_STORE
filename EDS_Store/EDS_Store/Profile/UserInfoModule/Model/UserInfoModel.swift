//
//  UserInfoModel.swift
//  EDS_Store
//
//  Created by Илья Морозов on 08.01.2025.
//

import UIKit

protocol UserInfoModelProtocol {
    func tapOnCell(index: Int) -> UIViewController
}

class UserInfoModel: UserInfoModelProtocol {
    func tapOnCell(index: Int) -> UIViewController {
        switch index {
            case 0:
            let vc = UserNameViewController()
            return vc
        case 1:
            let vc = UserSexViewController()
            return vc
        case 2:
            let vc = PhoneViewController()
            return vc
        case 3:
            let vc = AddressViewController()
            return vc
        case 4:
            let vc = NotificationViewController()
            return vc
        default:
            return UIViewController()
        }
    }
}
