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
    
    
}

