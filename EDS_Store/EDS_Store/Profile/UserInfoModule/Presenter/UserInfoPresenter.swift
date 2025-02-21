//
//  UserInfoPresenter.swift
//  EDS_Store
//
//  Created by Илья Морозов on 08.01.2025.
//

import UIKit

protocol UserInfoPresenterProtocol {
    init(model: UserInfoModelProtocol, router: ProfileRouterProtocol, view: UserInfoViewProtocol)
    func tapOnCell(index: Int) -> UIViewController
}

class UserInfoPresenter: UserInfoPresenterProtocol {
    
    required init(model: any UserInfoModelProtocol, router: any ProfileRouterProtocol, view: any UserInfoViewProtocol) {
        self.model = model
        self.router = router
        self.view = view
    }
    
    var router: ProfileRouterProtocol?
    weak var view: UserInfoViewProtocol?
    let model: UserInfoModelProtocol!
    
    func tapOnCell(index: Int) -> UIViewController {
        model.tapOnCell(index: index)
    }
    
}
