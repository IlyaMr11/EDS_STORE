//
//  MockRegPresenter.swift
//  EDS_StoreTests
//
//  Created by Илья Морозов on 18.02.2025.
//

import Foundation
@testable import EDS_Store

class MockRegistrationPresenter: RegistrationPresenterProtocol {
    
    weak var view: RegistrationViewProtocol?
    var router: ProfileRouterProtocol!
    let model: RegistrationModelProtocol!
    var alert: AlertType?
    
    func registerUser(_ fields: EDS_Store.Fields) {
        
    }
    
    
    required init(view: any EDS_Store.RegistrationViewProtocol, router: any EDS_Store.ProfileRouterProtocol, model: any EDS_Store.RegistrationModelProtocol) {
        self.model = model
        self.router = router
        self.view = view
    }
    
    func toSignIn() {
        
    }
    
    
}
