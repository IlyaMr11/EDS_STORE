//
//  BagModel.swift
//  EDS_Store
//
//  Created by Илья Морозов on 19.01.2025.
//

import UIKit

protocol BagModelProtocol {
    func deleteProduct(index: Int)
    func changeCount(index: Int, count: Int)
    func loadPhoto(urlString: String, completion: @escaping (UIImage?, AlertType?) -> Void)
    func loadData(completion: @escaping ([Position]?, AlertType?) -> Void)
}


class BagModel: BagModelProtocol {
    func changeCount(index: Int, count: Int) {
        UserBasket.shared.changeCount(index: index, count: count)
    }
    
    
    func loadPhoto(urlString: String, completion: @escaping (UIImage?, AlertType?) -> Void) {
        guard let url = URL(string: urlString) else {
            completion(nil, .serverError)
            print("incorrrect url")
            return
        }
        
        let task = URLSession.shared.dataTask(with: url) { data, _, error in
            if let _ = error {
                completion(nil, .serverError)
                return
            }
            
            guard let data = data else {
                completion(nil, .badConnection)
                return
            }
            DispatchQueue.main.async {
                completion(UIImage(data: data), nil)
            }
        }
        task.resume()
    }
    
    func loadData(completion: @escaping ([Position]?, AlertType?) -> Void) {
        if PersonData.shared.currentUser == nil {
            completion(nil, .noUser)
            return
        }
        
        if UserBasket.shared.currentBasket.isEmpty {
            completion(nil, .emptyBasket)
            return
        }
        
        completion(UserBasket.shared.currentBasket, nil)
    }
    
    
    func deleteProduct(index: Int) {
        UserBasket.shared.deleteProduct(index: index)
    }
    
    
}
