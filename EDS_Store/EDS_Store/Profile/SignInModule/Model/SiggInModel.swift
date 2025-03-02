//
//  SiggInModel.swift
//  EDS_Store
//
//  Created by Илья Морозов on 03.01.2025.
//

import Foundation


protocol SignInModelProtocol {
    init(networkService: ProfileNetworkServiceProtocol)
    func isUserDefine(login: String, password: String, completion: @escaping (AlertType?) -> ())
}

class SignInModel: SignInModelProtocol {
    var networkService: ProfileNetworkServiceProtocol
    
    required init(networkService: any ProfileNetworkServiceProtocol) {
        self.networkService = networkService
    }
    
    func isUserDefine(login: String, password: String, completion: @escaping (AlertType?) -> ()) {
        networkService.isUserExist(login: login, password: password) { alert in
            if let alert = alert {
                completion(alert)
                return
            }
            
            let person = Person(login: login, password: password)
            UserDefaultsData.shared.setUser(person)
            PersonData.shared.setUser(person)
            
            completion(nil)
        }
        
    }
    
}
