//
//  ProfilePresenter.swift
//  EDS_Store
//
//  Created by Илья Морозов on 01.01.2025.
//

import UIKit

protocol MainProfilePresenterProtocol {
    init(view: MainProfileViewProtocol, router: ProfileRouterProtocol, networkService: GetDataNetworkProtocol)
    func tapOnCell(data: AnyObject)
    func tapOnUserInfo()
}

class MainProfilePresenter: MainProfilePresenterProtocol {
    var router: ProfileRouterProtocol?
    weak var view: MainProfileViewProtocol?
    let networkService: GetDataNetworkProtocol!
    
    required init(view: any MainProfileViewProtocol, router: any ProfileRouterProtocol, networkService: any GetDataNetworkProtocol) {
        <#code#>
    }
    
    func tapOnCell(data: AnyObject) {
        <#code#>
    }
    
    func tapOnUserInfo() {
        <#code#>
    }
    
    
}
