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

struct anyProduct: Product, Codable {
    var name: String
    var price: String
    var productType: String
    var picture: String
    var someData: [String: String]
    
    init(from reducer: Reducer) {
        name = reducer.name
        price = reducer.price
        productType = reducer.productType
        picture = reducer.picture
        someData = ["size": reducer.size, "ratio": reducer.ratio, "type": reducer.type, "flange": reducer.flange]
    }
    
    init(from motor: Motor) {
        name = motor.name
        price = motor.price
        productType = motor.productType
        picture = motor.picture
        someData = ["power": motor.power, "size": motor.size, "type": motor.type, "flange": motor.flange]
    }
    
    init(name: String, price: String, productType: String, picture: String, someData: [String: String]) {
        self.name = name
        self.price = price
        self.productType = productType
        self.picture = picture
        self.someData = someData
    }
}
