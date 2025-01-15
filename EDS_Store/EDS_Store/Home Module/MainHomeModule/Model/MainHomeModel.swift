//
//  MainHomeModel.swift
//  EDS_Store
//
//  Created by Илья Морозов on 12.01.2025.
//

import Foundation

protocol MainHomeModelProtocol {
    init(networkService: HomeNetworkServiceProtocol)
    var networkService:  HomeNetworkServiceProtocol { get }
}

class MainHomeModel: MainHomeModelProtocol {
    var networkService:  HomeNetworkServiceProtocol
    
    required init(networkService: any HomeNetworkServiceProtocol) {
        self.networkService = networkService
    }
    
}
