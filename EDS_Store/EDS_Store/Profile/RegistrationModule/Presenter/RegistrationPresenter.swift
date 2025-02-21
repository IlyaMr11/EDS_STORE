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
    let alerts: [UIAlertController] = [AlertType.password.alert, AlertType.email.alert,
                                       AlertType.userName.alert, AlertType.confirmPassword.alert]
    
    required init(view: RegistrationViewProtocol, router: ProfileRouterProtocol, model: RegistrationModelProtocol) {
        self.view = view
        self.router = router
        self.model = model
    }
    
    func registerUser(_ fields: Fields) {
        let number = model.checkFields(fields: fields)
        if number > -1 {
            view?.failure(alert: alerts[number])
        } else {
            model.createUser(login: fields.login, password: fields.password, completion: { [weak self] error in
                
                switch error {
                case .loginNoFree:
                    DispatchQueue.main.async {
                        self?.view?.failure(alert: AlertType.loginNoFree.alert)
                    }
                case .serverError:
                    DispatchQueue.main.async {
                        self?.view?.failure(alert: AlertType.serverError.alert)
                    }
                case .success:
                    DispatchQueue.main.async {
                        self?.view?.success()
                    }
                }
            })
            
        }
    }
    
    func toSignIn() {
        print("fuck")
        router?.navigationController?.popViewController(animated: true)
    }
}
