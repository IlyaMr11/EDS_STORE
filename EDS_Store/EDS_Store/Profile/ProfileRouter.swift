//
//  ProfileRouter.swift
//  EDS_Store
//
//  Created by Илья Морозов on 02.01.2025.
//

import UIKit


protocol ProfileRouterProtocol {
    func showSignInModule()
    func showRegistrationModule()
    func showUserInfoModule()
    func showDeliveryModule()
    func showHistoryModule()
}

class ProfileRouter: RouterProtocol, ProfileRouterProtocol {
    
    
    var AssemblyBuilder: AssemblyBuilderProtocol?
    var navigationController: UINavigationController
    
    var profileAssemblyBuilder: ProfileAssemblyBuilderProtocol?
    
    init(naviagationControllet: UINavigationController, profileAssemblyBuilder: ProfileAssemblyBuilderProtocol) {
        self.navigationController = naviagationControllet
        self.profileAssemblyBuilder = profileAssemblyBuilder
    }
    
    func inititalProtocol() {
    }
    
    func popToRoot() {
        <#code#>
    }
    
    func showSignInModule() {
        <#code#>
    }
    
    func showRegistrationModule() {
        <#code#>
    }
    
    func showUserInfoModule() {
        <#code#>
    }
    
    func showDeliveryModule() {
        <#code#>
    }
    
    func showHistoryModule() {
        <#code#>
    }
    
}

