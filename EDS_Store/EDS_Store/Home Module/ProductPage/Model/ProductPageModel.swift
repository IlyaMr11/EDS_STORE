//
//  ProductPageModel.swift
//  EDS_Store
//
//  Created by Илья Морозов on 18.01.2025.
//

import Foundation

protocol ProductPageModelProtocol {
    func addProduct(product: Product)
}

class ProductPageModel: ProductPageModelProtocol {
    func addProduct(product: any Product) {
        UserBasket.shared.addProductToBasket(product, count: 1)
        print(UserBasket.shared.currentBasket)
    }
    
    
}
