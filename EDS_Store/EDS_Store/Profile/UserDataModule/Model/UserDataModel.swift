//
//  UserDataModel.swift
//  EDS_Store
//
//  Created by Илья Морозов on 05.02.2025.
//

import Foundation

protocol UserDataModelProtocol {
    func getUserData()
    func saveUserData(attr: DataAttrs, value: Any, completion: @escaping (UserDataError?) -> Void )
}


class UserDataModel: UserDataModelProtocol {
    func getUserData() {
        
    }
    
    func saveUserData(attr: DataAttrs, value: Any, completion: @escaping (UserDataError?) -> Void) {
        PersonData.shared.setDataAttrs(attr: attr, newValue: value)
        
        guard let login = PersonData.shared.currentUser?.login else {
            completion(.serverError)
            print("нет логина")
            return
        }
        
        print("")
        
        let db = FireBaseLayer.shared.configureFirebase()
        db.collection("UsersData").whereField("login", isEqualTo:  login).getDocuments { snapshot, error in
            if let error = error {
                print(error.localizedDescription)
                completion(.serverError)
                return
            }
            
            guard let document = snapshot?.documents.first else {
                print("no docuemnts nil")
                completion(.emptyData)
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
