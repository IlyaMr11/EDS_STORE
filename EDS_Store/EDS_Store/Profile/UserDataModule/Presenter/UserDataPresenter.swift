//
//  UserDataPresenter.swift
//  EDS_Store
//
//  Created by Илья Морозов on 05.02.2025.
//

import Foundation

protocol UserDataPresenterProtocol {
    func loadUserData(data: Any)
    func updateUserData(attr: DataAttrs, data: Any)
    init(view: UserDataViewProtocol, model: UserDataModelProtocol,  router: ProfileRouterProtocol)
}


class UserDataPresenter: UserDataPresenterProtocol {
    
    weak var view: UserDataViewProtocol?
    let model: UserDataModelProtocol!
    var router: ProfileRouterProtocol?
    
    required init(view: UserDataViewProtocol, model: UserDataModelProtocol,  router: ProfileRouterProtocol) {
        self.router = router
        self.view = view
        self.model = model
    }
    
    
    func loadUserData(data: Any) {
        
    }
        
    func updateUserData(attr: DataAttrs, data: Any) {
        model.saveUserData(attr: attr, value: data) { [weak self] error in
            if let error = error {
                DispatchQueue.main.async {
                    self?.view?.failure(error: error)
                    
                }
            }
        }
    }
    
        
}
