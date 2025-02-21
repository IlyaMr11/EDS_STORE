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
//        let viewArray = [UserNameViewController.self, UserSexViewController.self, PhoneViewController.self, AddressViewController.self, NotificationViewController.self]
//        return viewArray[index].init()
        return UIViewController()
            
        
    }
}
