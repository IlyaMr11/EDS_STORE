//
//  SiggInModel.swift
//  EDS_Store
//
//  Created by Илья Морозов on 03.01.2025.
//

import Foundation

protocol SignInModelProtocol {
    init(networkService: ProfileNetworkServiceProtocol)
    func isUserDefine(login: String, password: String) -> Bool
}

class SignInModel: SignInModelProtocol {
    var networkService: ProfileNetworkServiceProtocol
    
    required init(networkService: any ProfileNetworkServiceProtocol) {
        self.networkService = networkService
    }
    
    func isUserDefine(login: String, password: String) -> Bool {
        var result: Bool = false
        networkService.isUserExist(login: login, password: password, completion: { (bool, text) in
            if !bool && text != nil {
                print(text!)
            } else {
                result = true
            }
        })
        return result
        
    }
    
    
}
