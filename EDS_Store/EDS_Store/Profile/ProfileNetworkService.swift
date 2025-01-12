//
//  ProfileNetworkService.swift
//  EDS_Store
//
//  Created by Илья Морозов on 02.01.2025.
//

import UIKit
import Firebase
import FirebaseDatabase

protocol ProfileNetworkServiceProtocol {
    func getUserData(collection: String, docName: String, completion: @escaping (Person?) -> Void)
    func setUserData()
    func isUserExist(login: String, password: String, completion: @escaping (Bool, String?) -> Void)
}

class ProfileNetworkService:  ProfileNetworkServiceProtocol {
    
    static let shared = ProfileNetworkService()
    
    private func configureFirebase() -> Firestore {
        let db:  Firestore!
        let settings = FirestoreSettings()
        Firestore.firestore().settings = settings
        db = Firestore.firestore()
        return db
    }
    
    func isUserExist(login: String, password: String, completion: @escaping (Bool, String?) -> Void) {
        let db = configureFirebase()
        db.collection("User").whereField("login", isEqualTo: login).getDocuments { (querySnapshot, error) in
            if let error = error {
                print("Error - \(error.localizedDescription)")
                completion(false, "Error fetching user")
                return
            }
            
            guard let documents = querySnapshot?.documents, !documents.isEmpty else {
                print("User not found")
                completion(false, "User not found")
                return
            }
            
            let data = documents[0].data()
            let pass = data["password"] as? String ?? ""
            
            if pass == password {
                completion(true, nil)
            } else {
                completion(false, "wrong password")
            }
        }
    }
    
    func getUserData(collection: String, docName: String, completion: @escaping (Person?) -> Void) {
        let db = configureFirebase()
        db.collection(collection).document(docName).getDocument(completion: { (document, error) in
            guard error == nil else { completion(nil); return}
            let person = Person(login: document?.get("login") as! String, password: document?.get("password") as! String)
            completion(person)
        })
        
    }
    
    func createNewData(collection: String, docName: String, user: Person, completion: @escaping (Bool, String?) -> Void) {
            
    }
        
        

    func setUserData() {
        
    }
    
}
