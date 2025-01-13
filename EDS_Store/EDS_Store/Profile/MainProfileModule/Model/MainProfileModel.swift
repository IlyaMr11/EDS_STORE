//
//  ProfileData.swift
//  EDS_Store
//
//  Created by Илья Морозов on 01.01.2025.
//

import Foundation

protocol MainProfileModelProtocol {
    init (networkService: ProfileNetworkServiceProtocol)
}

class MainProfileModel: MainProfileModelProtocol {
    let networkService: ProfileNetworkServiceProtocol
    var name: String?
    
    required init(networkService: ProfileNetworkServiceProtocol) {
        self.networkService = networkService
    }
    
}


