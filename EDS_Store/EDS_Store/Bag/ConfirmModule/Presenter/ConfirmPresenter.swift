//
//  ConfirmPresenter.swift
//  EDS_Store
//
//  Created by Илья Морозов on 23.02.2025.
//

import Foundation

protocol ConfirmPresenterProtocol {
    init(view: ConfirmViewProtocol, router: BagRouterProtocol, model: ConfirmModelProtocol)
    func loadData()
    func laodAddress()
    func createOrder(address: String)
}

class ConfirmPresenter: ConfirmPresenterProtocol {
    weak var view: ConfirmViewProtocol?
    var router: BagRouterProtocol?
    let model: ConfirmModelProtocol
    
    required init(view: ConfirmViewProtocol, router: BagRouterProtocol, model: ConfirmModelProtocol) {
        self.view = view
        self.router = router
        self.model = model
    }
    
    func loadData() {
        model.loadProduct() { [weak self] (order, alert) in
            if let alert = alert {
                DispatchQueue.main.async {
                    self?.view?.failure(alert: alert)
                }
            }
            
            if let order = order {
                DispatchQueue.main.async {
                    self?.view?.success(order: order)
                }
            }
        }
    }
    
    func laodAddress() {
        model.loadAddress() { [weak self] (array, alert) in
            if let alert = alert {
                DispatchQueue.main.async {
                    self?.view?.failure(alert: alert)
                    return
                }
            }
            
            guard let array = array else { return }
            
            DispatchQueue.main.async {
                self?.view?.setupAddress(array)
            }
        }
    }
    
    func createOrder(address: String) {
        model.createOrder(address: address) { [weak self] (alert) in
            if let alert = alert {
                DispatchQueue.main.async {
                    self?.view?.failure(alert: alert)
                    return
                }
            }
            
            DispatchQueue.main.async {
                self?.router?.navigationController?.popViewController(animated: true)
                
            }
        }
    }
}
