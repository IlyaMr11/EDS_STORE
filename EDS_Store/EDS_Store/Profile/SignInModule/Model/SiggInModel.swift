//
//  SiggInModel.swift
//  EDS_Store
//
//  Created by Илья Морозов on 03.01.2025.
//

import Foundation

protocol SignInModelProtocol {
    func isUserDefine() -> Bool
}

class SignInModel: SignInModelProtocol {
    func isUserDefine() -> Bool {
        return true
    }
    
    
}
