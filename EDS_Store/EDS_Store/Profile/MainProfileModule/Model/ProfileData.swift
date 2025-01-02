//
//  ProfileData.swift
//  EDS_Store
//
//  Created by Илья Морозов on 01.01.2025.
//

import Foundation

class MainProfileModel {
    let getNetworkService: GetDataNetworkProtocol
    var name: String?
    
    init(getNetworkService: GetDataNetworkProtocol) {
        self.getNetworkService = getNetworkService
    }
    
}


