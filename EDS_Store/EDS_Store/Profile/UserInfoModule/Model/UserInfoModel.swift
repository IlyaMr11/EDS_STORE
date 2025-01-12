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
        let viewArray = [UserNameViewController(), UserSexViewController(), PhoneViewController(), AddressViewController(), NotificationViewController()]
        return viewArray[index]
            
        
    }
}
