//
//  HomeNetworkService.swift
//  EDS_Store
//
//  Created by Илья Морозов on 15.01.2025.
//

import UIKit
import Firebase
import FirebaseDatabase

protocol HomeFirebaseServiceProtocol {
    func getProductData(completion: @escaping ([Product]?, AlertType?) -> Void)
}

class HomeFirebaseService: HomeFirebaseServiceProtocol {
    
    static let shared = HomeFirebaseService()
    
    func getProductData(completion: @escaping ([Product]?, AlertType?) -> Void) {
        
        let db = FireBaseLayer.shared.configureFirebase()
        db.collection("Products").getDocuments { (querySnapshot, error) in
            if let _ = error {
                print("trouble")
                completion(nil, .serverError)
                return
            }
            
            guard let documents = querySnapshot?.documents else {
                completion(nil, .serverError)
                return
            }
            
            var products: [any Product] = []
            
            for document in documents {
                let data = document.data()
                guard let productType = data["productType"] as? String else { continue }
                switch productType {
                case "reducer":
                    let product = ProductDecoder.reducerDecoder(data)
                    products.append(product)
                case "motor":
                    let product = ProductDecoder.motorDecoder(data)
                    products.append(product)
                default:
                    continue
                }
            }
            
            completion(products, nil)
        }
    }
}
