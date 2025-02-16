//
//  ProfilePresenter.swift
//  EDS_Store
//
//  Created by Илья Морозов on 01.01.2025.
//

import UIKit

protocol MainProfilePresenterProtocol {
    init(view: MainProfileViewProtocol, router: ProfileRouterProtocol, model: MainProfileModel)
    func tapOnCell(index: Int)
    func tapOnUserInfo()
    func setupUser()
    func toSignIn()
    func loadName(_ login: String)
}

class MainProfilePresenter: MainProfilePresenterProtocol {
    
    
    var router: ProfileRouterProtocol?
    weak var view: MainProfileViewProtocol?
    let model: MainProfileModel?
    
    required init(view: MainProfileViewProtocol, router: any ProfileRouterProtocol, model:  MainProfileModel) {
        self.view = view
        self.router = router
        self.model = model
    }
    
    //MARK: - SHOW USER DATA MODULE
    func tapOnCell(index: Int) {
        router?.showUserDataModule(index: index)
    }
    
    func tapOnUserInfo() {
        router?.showUserInfoModule()
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
                }
            }
            
            DispatchQueue.main.async {
                self?.view?.updateName()
            }
        }
    }
}
