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
    func loadPhoto(path: String, completion: @escaping (UIImage?, AlertType?) -> Void)
}

class MainHomeModel: MainHomeModelProtocol {
    var firebaseService:  HomeFirebaseServiceProtocol
    
    required init(firebaseService: any HomeFirebaseServiceProtocol) {
        self.firebaseService = firebaseService
    }
    
    func loadPhoto(path: String, completion: @escaping (UIImage?, AlertType?) -> Void) {
        if path.isEmpty {
            completion(nil, .serverError)
            return
        }
        
        guard let url = URL(string: path) else {
            completion(nil, .serverError)
            return
        }
        
        let task = URLSession.shared.dataTask(with: url) { data, _, error in
            if let _ = error {
                print("error")
                completion(nil, .serverError)
                return
            }
            
            guard let data = data, let image = UIImage(data: data) else {
                completion(nil, .noData)
                return
            }
            
            completion(image, nil)
            return
        }
        task.resume()
    }
}
