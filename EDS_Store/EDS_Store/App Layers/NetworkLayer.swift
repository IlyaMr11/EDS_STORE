//
//  NetworkLayer.swift
//  EDS_Store
//
//  Created by Илья Морозов on 27.02.2025.
//

import Foundation
import UIKit


class NetworkLayer {
    static func loadPhoto(path: String, completion: @escaping (UIImage?, AlertType?) -> Void) {
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
