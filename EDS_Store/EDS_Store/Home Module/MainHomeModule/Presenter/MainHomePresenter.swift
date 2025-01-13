//
//  MainHomePresenter.swift
//  EDS_Store
//
//  Created by Илья Морозов on 12.01.2025.
//

import Foundation

protocol MainHomePresenterProtocol {
    init(model: MainHomeModelProtocol, router: HomeRouterProtocol, view: MainHomeViewProtocol)
    
}

class MainHomePresenter: MainHomePresenterProtocol {
    required init(model: any MainHomeModelProtocol, router: any HomeRouterProtocol, view: any MainHomeViewProtocol) {
        self.model = model
        self.router = router
        self.view = view
    }
    
    let model: MainHomeModelProtocol
    var router: HomeRouterProtocol?
    var view: MainHomeViewProtocol?
}
