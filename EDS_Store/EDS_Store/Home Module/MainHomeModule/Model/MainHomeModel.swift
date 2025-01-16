//
//  MainHomeModel.swift
//  EDS_Store
//
//  Created by Илья Морозов on 12.01.2025.
//

import UIKit

protocol MainHomeModelProtocol {
    init(firebaseService: HomeFirebaseServiceProtocol)
    var firebaseService:  HomeFirebaseServiceProtocol { get }
    func loadPhoto(path: String, completion: @escaping (UIImage?, String?) -> Void)
}

class MainHomeModel: MainHomeModelProtocol {
    var firebaseService:  HomeFirebaseServiceProtocol
    
    required init(firebaseService: any HomeFirebaseServiceProtocol) {
        self.firebaseService = firebaseService
    }
    
    func loadPhoto(path: String, completion: @escaping (UIImage?, String?) -> Void) {
        if path.isEmpty {
            completion(nil, "empty path")
            return
        }
        
        guard let url = URL(string: path) else {
            completion(nil, "incorrect url")
            return
        }
        
        let task = URLSession.shared.dataTask(with: url) { data, _, error in
            if let error = error {
                print("error")
                completion(nil, error.localizedDescription)
                return
            }
        
            guard let data = data, let image = UIImage(data: data) else {
                completion(nil, "incorrect data")
                return
            }
            
            completion(image, nil)
            return
        }
        task.resume()
    }
}
