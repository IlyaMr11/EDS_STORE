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
    
    func tapOnCell(index: Int) {
        switch index {
        case 0:
            router?.showHistoryModule()
        case 1:
            router?.showDeliveryModule()
        default:
            print("empty")
        }
    }
    
    func tapOnUserInfo() {
        router?.showUserInfoModule()
    }
    
    func toSignIn() {
        router?.showSignInModule()
    }
    
}
