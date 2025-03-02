//
//  MockModel.swift
//  EDS_StoreTests
//
//  Created by Илья Морозов on 18.02.2025.
//

import Foundation
@testable import EDS_Store

class MockMainProfileModel: MainProfileModelProtocol {
    func signOut() {
        self.userDefine = false
    }
    

    var flag: Bool = false
    var alert: AlertType?
    var userDefine: Bool = true
    var userLogin: String = ""
    
    func setupUser(completion: (EDS_Store.AlertType?) -> Void) {
        if self.flag {
            completion(nil)
        } else {
            completion(alert)
        }
    }
    
    func loadUserData(_ login: String, completion: @escaping (EDS_Store.AlertType?) -> Void) {
        self.userLogin = login
        completion(AlertType.badConnection)
        return
    }
}
