//
//  MainHomePresenter.swift
//  EDS_Store
//
//  Created by Илья Морозов on 12.01.2025.
//

import Foundation

protocol MainHomePresenterProtocol {
    init(view: MainHomeViewProtocol, router: HomeRouterProtocol, model:  MainHomeModelProtocol)
    
}

class MainHomePresenter: MainHomePresenterProtocol {
    required init(view: any MainHomeViewProtocol, router: any HomeRouterProtocol, model: any MainHomeModelProtocol) {
        self.model = model
        self.router = router
        self.view = view
    }
    
    let model: MainHomeModelProtocol
    var router: HomeRouterProtocol?
    var view: MainHomeViewProtocol?
}
