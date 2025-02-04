//
//  RegistrationModel.swift
//  EDS_Store
//
//  Created by Илья Морозов on 06.01.2025.
//

import Foundation

enum RegError {
    case serverError
    case loginNoFree
    case success
}

protocol RegistrationModelProtocol {
    func createUser(login: String, password: String, completion: @escaping (RegError) -> Void)
    func checkFields(fields: Fields) -> Int
}

class RegistrationModel: RegistrationModelProtocol {
    
    func checkFields(fields: Fields) -> Int {
        let checkingArray = [Checker.shared.checkPassword(fields.password),
                             Checker.shared.checkUserName(fields.name),
                             Checker.shared.checkEmail(fields.login),
                             Checker.shared.checkEqualPasswords(fields.password, fields.confirmPassword)]
        
        for i in 0..<checkingArray.count {
            if !checkingArray[i] {
                return  i
            }
        }
        return -1
    }
    
    
    func createUser(login: String, password: String, completion: @escaping (RegError) -> Void) {
        let db = FireBaseLayer.shared.configureFirebase()
        db.collection("Users").whereField("login", isEqualTo: login).getDocuments { (snapshot, error) in
            if let error = error {
                print("Ошибка \(error.localizedDescription)")
                completion(RegError.serverError)
                return
            }
            
            guard let snapshot = snapshot else {
                print("Snapshot is nil")
                completion(RegError.serverError)
                return
            }
            
            if !snapshot.documents.isEmpty {
                completion(RegError.loginNoFree)
                return
            }
            
            db.collection("Users").document().setData(["login": login, "password": password]) { error in
                if let error = error {
                    print("Error adding document: \(error)")
                    completion(RegError.serverError)
                    return
                }
                print("all - ok")
                completion(RegError.success)
            }
        }
        
    }
}

