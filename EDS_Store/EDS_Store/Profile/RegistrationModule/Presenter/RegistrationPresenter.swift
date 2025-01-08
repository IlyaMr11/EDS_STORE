//
//  RegistrationPresenter.swift
//  EDS_Store
//
//  Created by Илья Морозов on 06.01.2025.
//

import Foundation

protocol RegistrationPresenterProtocol {
    func toSignIn()
    init(view: RegistrationViewProtocol, router: ProfileRouterProtocol, model: RegistrationModelProtocol)
}


class RegistrationPresenter: RegistrationPresenterProtocol {
    weak var view: RegistrationViewProtocol?
    var router: ProfileRouterProtocol?
    let model: RegistrationModelProtocol!
    
    required init(view: RegistrationViewProtocol, router: ProfileRouterProtocol, model: RegistrationModelProtocol) {
        self.view = view
        self.router = router
        self.model = model
    }
    
    func toSignIn() {
        
    }
}
