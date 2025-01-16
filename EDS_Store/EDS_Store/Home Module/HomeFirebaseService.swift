//
//  HomeNetworkService.swift
//  EDS_Store
//
//  Created by Илья Морозов on 15.01.2025.
//

import UIKit

protocol HomeFirebaseServiceProtocol {
    func getProductData(completion: @escaping ([Product]?, String?) -> Void)
}

class HomeFirebaseService: HomeFirebaseServiceProtocol {
    
    static let shared = HomeFirebaseService()
    
    func getProductData(completion: @escaping ([Product]?, String?) -> Void) {
        DispatchQueue.global().async {
            print("hi")
            let db = FireBaseLayer.shared.configureFirebase()
            db.collection("Products").getDocuments { (querySnapshot, error) in
                if let error = error {
                    print("trouble \(error.localizedDescription)")
                    DispatchQueue.main.async {
                        print("trouble")
                        completion(nil, "Server error")
                    }
                    return
                }
                
                guard let documents = querySnapshot?.documents else {
                    DispatchQueue.main.async {
                        completion(nil, "No data")
                    }
                    
                    return
                }
                
                let products = documents.compactMap { document -> Product?  in
                    let data = document.data()
                    print("Document data: \(data)")
                    return Product(
                        name: data["name"] as? String ?? "",
                        ratio: data["ratio"] as? String ?? "",
                        flange: data["flange"] as? String ?? "",
                        price: data["price"] as? String ?? "",
                        type: data["type"] as? String ?? "",
                        size: data["size"] as? String ?? "",
                        picture: data["picture"] as? String ?? ""
                    )
                }
                DispatchQueue.main.async {
                    completion(products, nil)
                }
            }
        }
    }
    
    
}
