//
//  SiggInModel.swift
//  EDS_Store
//
//  Created by Илья Морозов on 03.01.2025.
//

import Foundation


protocol SignInModelProtocol {
    init(networkService: ProfileNetworkServiceProtocol)
    func isUserDefine(login: String, password: String)  -> (Bool, String)
}

class SignInModel: SignInModelProtocol {
    var networkService: ProfileNetworkServiceProtocol
    
    required init(networkService: any ProfileNetworkServiceProtocol) {
        self.networkService = networkService
    }
    
    func isUserDefine(login: String, password: String) -> (Bool, String) {
        var result: Bool = false
        var message = ""
        let group = DispatchGroup()
        group.enter()
        print("hi")
        networkService.isUserExist(login: login, password: password, completion: { (bool, text) in
            if !bool {
                message = text ?? "error"
            }
            result = bool
            group.leave()
        })
        group.wait()
        return (result, message)
    }
    
}
