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
}
