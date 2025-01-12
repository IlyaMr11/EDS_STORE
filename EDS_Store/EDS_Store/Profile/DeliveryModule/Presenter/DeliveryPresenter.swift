//
//  DeliveryPresenter.swift
//  EDS_Store
//
//  Created by Илья Морозов on 09.01.2025.
//

import Foundation

protocol DeliveryPresenterProtocol {
    init(view: DeliveryViewProtocol, router: ProfileRouterProtocol, model: DeliveryModelProtocol)
}

class DeliveryPresenter: DeliveryPresenterProtocol {
    
    weak var view: DeliveryViewProtocol?
    let router: ProfileRouterProtocol!
    var model: DeliveryModelProtocol?
    
    required init(view: any DeliveryViewProtocol, router: ProfileRouterProtocol, model: any DeliveryModelProtocol) {
        self.view = view
        self.model = model
        self.router = router
    }
}
