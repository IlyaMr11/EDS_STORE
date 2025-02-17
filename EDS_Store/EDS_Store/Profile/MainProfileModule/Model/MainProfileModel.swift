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
            
            print("Login: \(login)")
            
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
            
            print("Snapshot documents count: \(snapshot.documents.count)")
            
            let document = snapshot.documents[0]
            let data = document.data()
            
            let name = data["name"] as? String ?? ""
            let phone = data["phone"] as? String ?? ""
            let notify = data["notify"] as? Bool ?? false
            let p = data["purchase"] as? [[String: Any]] ?? [[:]]
            let address = data["address"] as? [String] ?? []
            
            var purchases = [(Product, Int, String)]()
            for complex in p {
                let status = complex["status"] as? String ?? ""
                let count = complex["count"] as? Int ?? 0
                let pr = complex["product"] as? [String: Any] ?? [:]
                let product = ProductDecoder.prodcutDecoder(pr)
                purchases.append((product, count, status))
            }
            
            let userData = UserData(login: login, name: name, purchase: purchases, phone: phone, address: address, notify: notify)
            PersonData.shared.setUserData(userData)
            completion(nil)
        }
    }
    
    func signOut() {
        PersonData.shared.removeUser()
        UserDefaultsData.shared.clearUser()
    }
}


