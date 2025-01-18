//
//  Product.swift
//  EDS_Store
//
//  Created by Илья Морозов on 14.01.2025.
//

import Foundation

protocol Product: Codable {
    var name: String { get }
    var price: String { get }
    var productType: String { get }
    var picture: String { get }
}


struct Motor: Product, Codable {
    var name: String
    var price: String
    var productType: String
    var picture: String
    var power: String
    var size: String
    var type: String
    var flange: String
}

struct Reducer: Product, Codable {
    var name: String
    var price: String
    var productType: String
    var picture: String
    var size: String
    var ratio: String
    var type: String
    var flange: String
}

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
    
    
}
