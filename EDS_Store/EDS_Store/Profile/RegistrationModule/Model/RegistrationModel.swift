//
//  RegistrationModel.swift
//  EDS_Store
//
//  Created by Илья Морозов on 06.01.2025.
//

import Foundation


protocol RegistrationModelProtocol {
    func createUser(fields: Fields, completion: @escaping (AlertType?) -> Void)
    func checkFields(fields: Fields) -> AlertType?
}

class RegistrationModel: RegistrationModelProtocol {
    
    func checkFields(fields: Fields) -> AlertType? {
        let alerts: [AlertType] = [.password, .userName, .email, .confirmPassword]
        let checkingArray = [Checker.shared.checkPassword(fields.password),
                             Checker.shared.checkUserName(fields.name),
                             Checker.shared.checkEmail(fields.login),
                             Checker.shared.checkEqualPasswords(fields.password, fields.confirmPassword)]
        
        for (b, alert) in zip(checkingArray, alerts) {
            if !b {
                return alert
            }
        }
        
        return nil
    }
    
    
    func createUser(fields: Fields, completion: @escaping (AlertType?) -> Void) {
        if let alert = checkFields(fields: fields) {
            completion(alert)
            return
        }
        
        let password = fields.password, login = fields.login, name = fields.name
        
        let db = FireBaseLayer.shared.configureFirebase()
        db.collection("Users").whereField("login", isEqualTo: login).getDocuments { (snapshot, error) in
            
            
            if error != nil {
                completion(AlertType.serverError)
                return
            }
            
            guard let snapshot = snapshot else {
                completion(AlertType.serverError)
                return
            }
            
            if !snapshot.documents.isEmpty {
                completion(AlertType.loginNoFree)
                return
            }
            
            db.collection("Users").document().setData(["login": login, "password": password]) { error in
                if error != nil {
                    completion(AlertType.serverError)
                    return
                }
            }
            
            db.collection("UsersData").document().setData(["login": login, "name": name]) { error in
                if error != nil {
                    print("UsersData server error")
                    completion(AlertType.serverError)
                    return
                }
                
                completion(nil)
            }
        }
        
    }
}

