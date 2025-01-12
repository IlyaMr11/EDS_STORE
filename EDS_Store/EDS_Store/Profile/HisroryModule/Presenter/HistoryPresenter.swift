//
//  HistoryPresenter.swift
//  EDS_Store
//
//  Created by Илья Морозов on 09.01.2025.
//

import UIKit

protocol HistoryPresenterProtocol {
    init(view: HistoryViewProtocol, router: ProfileRouterProtocol, model: HistoryModel)
}

class HistoryPresenter: HistoryPresenterProtocol {
    weak var view: HistoryViewProtocol?
    var router: ProfileRouterProtocol?
    let model: HistoryModel!
    
    required init(view: any HistoryViewProtocol, router: any ProfileRouterProtocol, model: HistoryModel) {
        self.view = view
        self.router = router
        self.model = model
    }
    
}
