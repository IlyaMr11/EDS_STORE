//
//  ProductDecoder.swift
//  EDS_Store
//
//  Created by Илья Морозов on 20.02.2025.
//

import Foundation

class ProductDecoder {
    
    static func motorDecoder(_ data: [String: Any]) -> Motor {
        return Motor(
            name: data["name"] as? String ?? "",
            price: data["price"] as? String ?? "",
            productType: data["productType"] as? String ?? "",
            picture: data["picture"] as? String ?? "",
            power: data["power"] as? String ?? "",
            size: data["size"] as? String ?? "",
            type: data["type"] as? String ?? "",
            flange: data["flange"] as? String ?? ""
        )
    }
    
    static func reducerDecoder(_ data: [String: Any]) -> Reducer {
        return Reducer(
            name: data["name"] as? String ?? "",
            price: data["price"] as? String ?? "",
            productType: data["productType"] as? String ?? "",
            picture: data["picture"] as? String ?? "",
            size: data["flange"] as? String ?? "",
            ratio: data["ratio"] as? String ?? "",
            type: data["size"] as? String ?? "",
            flange: data["type"] as? String ?? ""
            )
    }
    
    static func productDecode(_ data: [String: Any]) -> anyProduct {
        return anyProduct(
            name: data["name"] as? String ?? "",
            price: data["price"] as? String ?? "",
            productType: data["productType"] as? String ?? "",
            picture: data["picture"] as? String ?? "",
            someData: [:]
        )
    }
}
