//
//  MockPresetner.swift
//  EDS_StoreTests
//
//  Created by Илья Морозов on 18.02.2025.
//

import Foundation
@testable import EDS_Store

class MockMainProfilePresenter: MainProfilePresenterProtocol {
    
    weak var view: MainProfileViewProtocol!
    var router: ProfileRouterProtocol?
    let model: MainProfileModelProtocol!
    var error: AlertType?
    
    required init(view: any EDS_Store.MainProfileViewProtocol, router: any EDS_Store.ProfileRouterProtocol, model: any EDS_Store.MainProfileModelProtocol) {
        self.view = view
        self.model = model
        self.router = router
    }
    
    func tapOnCell(index: Int) {
        
    }
    
    func setupUser() {
        model?.setupUser { [weak self] alert in
            if let alert = alert {
                self?.error = alert
            }
        }
    }
    
    func toSignIn() {
        
    }
    
    func loadName(_ login: String) {
        model?.loadUserData(login) { [weak self] error in
            if let error = error {
                print("error - \(error)")
                self?.error = error
            }
            
        }
    }
    
    func signOut() {
        
    }
    
}
