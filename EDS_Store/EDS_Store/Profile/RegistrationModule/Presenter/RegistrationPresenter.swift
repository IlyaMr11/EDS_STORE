//
//  RegistrationPresenter.swift
//  EDS_Store
//
//  Created by Илья Морозов on 06.01.2025.
//

import Foundation
import UIKit

protocol RegistrationPresenterProtocol {
    func registerUser(_ fields: Fields)
    init(view: RegistrationViewProtocol, router: ProfileRouterProtocol, model: RegistrationModelProtocol)
    func toSignIn()
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
    
    func registerUser(_ fields: Fields) {
        model.createUser(fields: fields) { [weak self] error in
            guard let error = error else {
                DispatchQueue.main.async {
                    self?.view?.success()
                }
                return
            }
                
            DispatchQueue.main.async {
                self?.view?.failure(alert: error.alert)
            }
        }
    }
    
    func toSignIn() {
        router?.navigationController?.popViewController(animated: true)
    }
}
