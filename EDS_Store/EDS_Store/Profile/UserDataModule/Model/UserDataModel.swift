//
//  UserDataModel.swift
//  EDS_Store
//
//  Created by Илья Морозов on 05.02.2025.
//

import Foundation

protocol UserDataModelProtocol {
    func getUserData(attr: DataAttrs, completion: @escaping (Any?) -> Void)
    func saveUserData(attr: DataAttrs, value: Any, completion: @escaping (AlertType?) -> Void )
}


class UserDataModel: UserDataModelProtocol {
    func getUserData(attr: DataAttrs, completion: (Any?) -> Void) {
        let data = UserDataConvertor.getData(attr: attr)
        completion(data)
    }
    
    func isDataValid(attr: DataAttrs, value: Any) -> Bool {
        switch attr {
        case .name:
            return Checker.shared.checkUserName(value as? String ?? "")
        case .phone:
            return Checker.shared.checkPhone(value as? String ?? "")
            
        default: return true
        }
    }
    
    func saveUserData(attr: DataAttrs, value: Any, completion: @escaping (AlertType?) -> Void) {
        
        
        if !isDataValid(attr: attr, value: value) {
            completion(.dataError)
            return
        }
        
        PersonData.shared.setDataAttrs(attr: attr, newValue: value)
        
        guard let login = PersonData.shared.currentUser?.login else {
            completion(.serverError)
            print("нет логина")
            return
        }
        
        
        let db = FireBaseLayer.shared.configureFirebase()
        db.collection("UsersData").whereField("login", isEqualTo:  login).getDocuments { snapshot, error in
            if let error = error {
                print(error.localizedDescription)
                completion(.serverError)
                return
            }
            
            guard let document = snapshot?.documents.first else {
                print("no docuemnts nil")
                completion(.serverError)
                return
            }
            
            
            document.reference.updateData([attr.rawValue: value]) { error in
                if let error = error {
                    print(error.localizedDescription)
                    completion(.serverError)
                    return
                }
                print("good save")
                completion(nil)
            }
            
        }
    }
    
        
}
