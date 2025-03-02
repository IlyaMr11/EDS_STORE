//
//  MainHomeModel.swift
//  EDS_Store
//
//  Created by Илья Морозов on 12.01.2025.
//

import UIKit

protocol MainHomeModelProtocol {
    init(firebaseService: HomeFirebaseServiceProtocol)
    var firebaseService:  HomeFirebaseServiceProtocol { get }
}

class MainHomeModel: MainHomeModelProtocol {
    var firebaseService:  HomeFirebaseServiceProtocol
    
    required init(firebaseService: any HomeFirebaseServiceProtocol) {
        self.firebaseService = firebaseService
    }
    
}
