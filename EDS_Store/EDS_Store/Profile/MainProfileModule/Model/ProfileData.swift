//
//  ProfileData.swift
//  EDS_Store
//
//  Created by Илья Морозов on 01.01.2025.
//

import Foundation

class MainProfileModel {
    let networkService: ProfileNetworkServiceProtocol
    var name: String?
    
    init(networkService: ProfileNetworkServiceProtocol) {
        self.networkService = networkService
    }
    
}


