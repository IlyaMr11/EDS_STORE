//
//  ProfileData.swift
//  EDS_Store
//
//  Created by Илья Морозов on 01.01.2025.
//

import Foundation


protocol MainProfileModelProtocol {
    func setupUser(completion: (AlertType?) -> Void)
    func loadUserData(_ login: String, completion: @escaping (AlertType?) -> Void)
    func signOut()
}

class MainProfileModel: MainProfileModelProtocol {
    
    //MARK: - SETUP USER FROM USER DEF
    func setupUser(completion: (AlertType?) -> Void) {
        if let person = UserDefaultsData.shared.getUser() {
            PersonData.shared.setUser(person)
            completion(nil)
            return
        }
        completion(AlertType.noUser)
        return
    }
    
    //MARK: - LOAD USER DATA
    func loadUserData(_ login: String, completion: @escaping (AlertType?) -> Void) {
        let db = FireBaseLayer.shared.configureFirebase()
        db.collection("UsersData").whereField("login", isEqualTo: login).getDocuments { (snapshot, error) in
            if let error = error {
                print("Error - \(error.localizedDescription)")
                completion(AlertType.badConnection)
                return
            }
            
            guard let snapshot = snapshot else {
                print("Error - snapshot is nil")
                completion(AlertType.serverError)
                return
            }
            
            if snapshot.isEmpty {
                print("Error - snapshot is empty")
                completion(AlertType.serverError)
                return
            }
        
            let document = snapshot.documents[0]
            let data = document.data()
            
            FireBaseLayer.shared.getDocumentID(login: login) { (id, alert) in
                if let alert = alert {
                    completion(alert)
                    return
                }
                
                db.collection("UsersData").document(id).collection("purchase").getDocuments { (snapshot, error) in
                    if let error = error {
                        print("Error - \(error.localizedDescription)")
                        completion(.serverError)
                        return
                    }
                    
                   guard let snapshot = snapshot else {
                        print("Error - snapshot is nil")
                        completion(nil)
                        return
                    }
                    
                    let doc = snapshot.documents
                    var purchases = [Purchase]()
                    for position in doc {
                        let dict = position.data() as [String: Any]
                        purchases.append(PurchaseDecoder.decode(dict))
                    }
                    
                    var userData = UserDataCoder.decode(data: data)
                    userData?.purchase = purchases
                    PersonData.shared.setUserData(userData)
                    completion(nil)
                }
            }
        }
    }
    
    func signOut() {
        PersonData.shared.removeUser()
        UserDefaultsData.shared.clearUser()
        UserBasket.shared.removeData()
        UserDefaultsBasket.shared.clearBasket()
    }
    
    
}


