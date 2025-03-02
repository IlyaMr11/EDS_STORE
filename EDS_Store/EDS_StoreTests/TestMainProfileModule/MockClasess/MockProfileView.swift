//
//  MockMainProfileView.swift
//  EDS_StoreTests
//
//  Created by Илья Морозов on 18.02.2025.
//

import Foundation
@testable import EDS_Store


class MockMainProfileView: MainProfileViewProtocol {
    var alertName: String?
    var name: String?
    var bool: Bool?
    var presenter: MainProfilePresenterProtocol?
    
    
    func success() {
        bool = true
    }
    
    func updateName() {
        self.name = PersonData.shared.userData?.name
    }
    
    func failure(alert: EDS_Store.AlertType) {
        self.alertName = alert.rawValue
    }
    
}
