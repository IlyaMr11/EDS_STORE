//
//  FireBaseLayer.swift
//  EDS_Store
//
//  Created by Илья Морозов on 15.01.2025.
//

import Foundation
import Firebase
import FirebaseDatabase

class FireBaseLayer {
    static let shared = FireBaseLayer()

    func configureFirebase() -> Firestore {
        let db:  Firestore!
        let settings = FirestoreSettings()
        Firestore.firestore().settings = settings
        db = Firestore.firestore()
        return db
    }
    
    func getDocumentID(login: String, completion: @escaping (String, AlertType?) -> Void) {
        let db = configureFirebase()
        db.collection("UsersData").whereField("login", isEqualTo: login).getDocuments { (snapshot, error) in
            if let _ = error {
                completion("", .serverError)
                return
            }
            
            guard let snapshot = snapshot else {
                completion("", .serverError)
                return
            }
            
            let document = snapshot.documents
            if document.isEmpty {
                completion("", .serverError)
                return
            }
        
            let docID = document[0].documentID
            completion(docID, nil)
        }
    }
}

