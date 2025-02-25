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
        var res: anyProduct?
        switch product.productType {
        case "motor":
            res = anyProduct(from: product as! Motor)
        case "reducer":
            res = anyProduct(from: product as! Reducer)
        default:
            res = product as? anyProduct
        }
        
        if let res = res {
            UserBasket.shared.addProductToBasket(res, count: 1)
        }
    }
    
    
}
