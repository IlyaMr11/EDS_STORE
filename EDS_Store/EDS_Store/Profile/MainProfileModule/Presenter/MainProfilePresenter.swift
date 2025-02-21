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
    
    //MARK: - LOAD ALL USER DATA
    func loadName(_ login: String) {
        model?.loadUserData(login, completion: { [weak self] (userData, error) in
            if let error = error {
                switch error {
                case .serverError:
                    DispatchQueue.main.async {
                        self?.view?.failure(alert: AlertType.serverError.alert)
                    }
                    return
                case .noInternet:
                    DispatchQueue.main.async {
                        self?.view?.failure(alert: AlertType.serverError.alert)
                        return
                    }
                default:
                    return
                }
            }
            
            guard let userData = userData else {
                print("Error loading user data")
                return
            }
            
            DispatchQueue.main.async {
                self?.view?.setupName(userData.name ?? "")
            }
        })
    }
}
