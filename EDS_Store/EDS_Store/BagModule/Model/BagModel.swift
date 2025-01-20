//
//  BagModel.swift
//  EDS_Store
//
//  Created by Илья Морозов on 19.01.2025.
//

import UIKit

protocol BagModelProtocol {
    func deleteProduct(product: Product, user: UserBag)
    func changeCount(product: Product, count: Int, user: UserBag)
    func loadPhoto(urlString: String, completion: @escaping (UIImage?) -> Void)
}

class BagModel: BagModelProtocol {
    func changeCount(product: any Product, count: Int, user: UserBag) {
        
    }
    
    func loadPhoto(urlString: String, completion: @escaping (UIImage?) -> Void) {
        guard let url = URL(string: urlString) else {
            completion(nil)
            print("incorrrect url")
            return
        }
        
        let task = URLSession.shared.dataTask(with: url) { data, _, error in
            guard let data = data else {
                completion(nil)
                print("error downloading data: \(error?.localizedDescription ?? "No description")")
                return
            }
            DispatchQueue.main.async {
                completion(UIImage(data: data))
            }
        }
        task.resume()
    }
    
    func deleteProduct(product: any Product, user: UserBag) {
        
    }
    
    
}
