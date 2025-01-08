//
//  ProfilePresenter.swift
//  EDS_Store
//
//  Created by Илья Морозов on 01.01.2025.
//

import UIKit

protocol MainProfilePresenterProtocol {
    init(view: MainProfileViewProtocol, router: ProfileRouterProtocol, networkService: ProfileNetworkServiceProtocol)
    func tapOnCell(data: AnyObject)
    func tapOnUserInfo()
    func toSignIn()
}

class MainProfilePresenter: MainProfilePresenterProtocol {
    
    var router: ProfileRouterProtocol?
    weak var view: MainProfileViewProtocol?
    let networkService: ProfileNetworkServiceProtocol!
    
    required init(view: MainProfileViewProtocol, router: any ProfileRouterProtocol, networkService:  ProfileNetworkServiceProtocol) {
        self.view = view
        self.router = router
        self.networkService = networkService
    }
    
    func tapOnCell(data: AnyObject) {
        
    }
    
    func tapOnUserInfo() {
        router?.showUserInfoModule()
    }
    
    func toSignIn() {
        router?.showSignInModule()
    }
    
}
