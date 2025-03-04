//
//  ConfirmModel.swift
//  EDS_Store
//
//  Created by Илья Морозов on 23.02.2025.
//

import UIKit

struct OrderData {
    var images: [UIImage]
    var total: Int
    var count: Int
}

protocol ConfirmModelProtocol {
    func loadProduct(completion: @escaping (OrderData?, AlertType?) -> Void)
    func loadAddress(completion: @escaping ([String]?, AlertType?) -> Void)
    func createOrder(address: String, completion: @escaping (AlertType?) -> Void)
}


class ConfirmModel: ConfirmModelProtocol {
    
    //MARK: - PROTOCOL METHODS
    
    func loadProduct(completion: @escaping (OrderData?, AlertType?) -> Void) {
        if UserBasket.shared.currentBasket.count == 0 {
            completion(nil, .emptyBasket)
        }
        
        DispatchQueue.global().async { 
            var total = 0
            var cnt = 0
            let group = DispatchGroup()
            var arrayImages: [UIImage] = []
            
            for position in UserBasket.shared.currentBasket {
                group.enter()
                
                let product = position.product, count = position.count
                total += (Int(product.price) ?? 0) * count
                cnt += count
                let url = product.picture
                
                NetworkLayer.loadPhoto(path: url) { (image, alert) in
                    if let alert = alert {
                        completion(nil, alert)
                        group.leave()
                        return
                    }
                    
                    guard let image = image else { completion(nil, .serverError); return }
                    arrayImages.append(image)
                    group.leave()
                }
            }
            group.wait()
            completion(OrderData(images: arrayImages, total: total, count: cnt), nil)
        }
    }
    
    func loadAddress(completion: @escaping ([String]?, AlertType?) -> Void) {
        guard let addresses = PersonData.shared.userData?.address else  {
            completion(nil, .noAddress)
            return
        }
        
        if addresses.isEmpty {
            completion(nil, .noAddress)
            return
        }
        
        completion(addresses, nil)
    }
    
    func createOrder(address: String, completion: @escaping (AlertType?) -> Void) {
        if address.isEmpty {
            completion(.serverError)
            return
        }
        
        let date = Date()
        let group = DispatchGroup()
        group.enter()
        pushOrder(address: address, date: date) { alert in
            if let alert = alert {
                completion(alert)
                group.leave()
                return
            }
            group.leave()
            
        }
        group.wait()
        
        PersonData.shared.createOrder(address: address, date: date)
        UserBasket.shared.removeData()
        UserDefaultsBasket.shared.clearBasket()
        completion(nil)
    }
    
    func pushOrder(address: String, date: Date, completion: @escaping (AlertType?) -> Void) {
        FireBaseLayer.shared.getDocumentID(login: PersonData.shared.userData?.login ?? "") { (id, alert) in
            if let alert = alert {
                completion(alert)
                return
            }
         
            guard id != "" else {
                completion(.serverError)
                return
            }
            
            let newPurchases = PurchaseEncoder.encode(address: address,
                                                      basket: UserBasket.shared.currentBasket,
                                                      date: date)
            for purchase in newPurchases {
                let db = FireBaseLayer.shared.configureFirebase()
                db.collection("UsersData").document(id).collection("purchase").addDocument(data: purchase) { (error) in
                    if let _ = error {
                        completion(.serverError)
                        return
                    }
                }
            }
            completion(nil)
        }
    }
    
}
