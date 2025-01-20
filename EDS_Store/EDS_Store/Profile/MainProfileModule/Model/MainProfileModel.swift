//
//  ProfileData.swift
//  EDS_Store
//
//  Created by Илья Морозов on 01.01.2025.
//

import Foundation

protocol MainProfileModelProtocol {
    init (networkService: ProfileNetworkServiceProtocol)
    var user: Person? { get set }
}

class MainProfileModel: MainProfileModelProtocol {
    let networkService: ProfileNetworkServiceProtocol
    var name: String?
    var user: Person?
    
    
    required init(networkService: ProfileNetworkServiceProtocol) {
        self.networkService = networkService
    }
    
}


