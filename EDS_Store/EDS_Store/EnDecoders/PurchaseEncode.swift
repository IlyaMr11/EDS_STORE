//
//  PurchaseEncode.swift
//  EDS_Store
//
//  Created by Илья Морозов on 26.02.2025.
//

import Foundation


class PurchaseEncoder {
    static func encode(address: String, basket: [Position], date: Date) -> [[String: Any]] {
        var result = [[String: Any]]()
        for position in basket {
            let count = position.count, product = position.product
            let dict: [String: Any] = ["address": address, "count": count, "status": "on track",
                                       "product": ["name": product.name,
                                                 "picture": product.picture,
                                                 "price": product.price,
                                                 "productType": product.productType], "date": date]
            result.append(dict)
        }
        return result
    }
}

class PurchaseDecoder {
    static func decode(_ data: [String: Any]) -> Purchase {
        return Purchase(
            product: ProductDecoder.productDecode(data["product"] as? [String: Any] ?? [:]),
            count: data["count"] as? Int ?? 0,
            date: data["date"] as? Date ?? Date(),
            status: data["status"] as? String ?? "",
            address: data["address"] as? String ??  "")
    }
}
