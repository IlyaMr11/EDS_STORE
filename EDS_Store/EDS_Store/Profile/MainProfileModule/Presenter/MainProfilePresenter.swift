//
//  ProfilePresenter.swift
//  EDS_Store
//
//  Created by Илья Морозов on 01.01.2025.
//

import UIKit

protocol MainProfilePresenterProtocol {
    init(view: MainProfileViewProtocol, router: ProfileRouterProtocol, model: MainProfileModelProtocol)
    func tapOnCell(index: Int)
    func setupUser()
    func toSignIn()
    func loadName(_ login: String)
    func signOut()
}

class MainProfilePresenter: MainProfilePresenterProtocol {
    
    
    var router: ProfileRouterProtocol?
    weak var view: MainProfileViewProtocol?
    let model: MainProfileModelProtocol?
    
    required init(view: MainProfileViewProtocol, router: any ProfileRouterProtocol, model:  MainProfileModelProtocol) {
        self.view = view
        self.router = router
        self.model = model
    }
    
    //MARK: - SHOW USER DATA MODULE
    func tapOnCell(index: Int) {
        router?.showUserDataModule(index: index)
    }
    
    //MARK: - SHOW SIGN IN MODULE
    func toSignIn() {
        router?.showSignInModule()
    }
    
    func setupUser() {
        model?.setupUser() { [weak self] alert in
            if let alert = alert {
                DispatchQueue.main.async {
                    self?.view?.failure(alert: alert)
                }
                return
            }
            
            DispatchQueue.main.async {
                self?.view?.success()
            }
        }
    }
    
    //MARK: - LOAD ALL USER DATA
    func loadName(_ login: String) {
        model?.loadUserData(login) { [weak self] error in
            if let error = error {
                DispatchQueue.main.async {
                    self?.view?.failure(alert: error)
                    print("I push error on View")
                }
            }
            
            DispatchQueue.main.async {
                self?.view?.updateName()
            }
        }
    }
    
    func signOut() {
        model?.signOut()
        DispatchQueue.main.async { [weak self] in
            let newView = MainProfileView()
            newView.presenter = self
            self?.router?.navigationController?.viewControllers[0] = newView
            self?.view = newView
        }
    }
}
