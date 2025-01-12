//
//  RegistrationModel.swift
//  EDS_Store
//
//  Created by Илья Морозов on 06.01.2025.
//

import Foundation

protocol RegistrationModelProtocol {
    init(networkService: ProfileNetworkServiceProtocol)
    func createUser(login: String, password: String) -> Bool
}

class RegistrationModel: RegistrationModelProtocol {
    var networkService: ProfileNetworkServiceProtocol
    
    required init(networkService: any ProfileNetworkServiceProtocol) {
        self.networkService = networkService
    }
    
    func createUser(login: String, password: String) -> Bool {
        return true
    }
    
    
}
