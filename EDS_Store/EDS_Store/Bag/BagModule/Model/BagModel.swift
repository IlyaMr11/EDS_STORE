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
    func loadData(completion: @escaping ([Position]?, AlertType?) -> Void)
}


class BagModel: BagModelProtocol {
    
    //MARK: - CANGEG VALUE
    
    func changeCount(index: Int, count: Int) {
        UserBasket.shared.changeCount(index: index, count: count)
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
