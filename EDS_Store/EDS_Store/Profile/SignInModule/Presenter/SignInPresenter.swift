//
//  SignInPresener.swift
//  EDS_Store
//
//  Created by Илья Морозов on 03.01.2025.
//

import UIKit

protocol SignInPresenterProtocol {
    init(view: SignInViewProtocol, router: ProfileRouterProtocol, model: SignInModelProtocol)
    func toRegistation()
    func toMainProfile(login: String, password: String)
}

class SignInPresenter: SignInPresenterProtocol {
    var router: ProfileRouterProtocol?
    weak var view: SignInViewProtocol?
    let model: SignInModelProtocol!
   
    required init(view: any SignInViewProtocol, router: any ProfileRouterProtocol, model: SignInModelProtocol) {
        self.view = view
        self.router = router
        self.model = model
    }
    
    func toRegistation() {
        router?.showRegistrationModule()
    }
    
    func toMainProfile(login: String, password: String) {
        if model.isUserDefine(login: login, password: password) {
            router?.initinal()
        }
        
    }
    
}
