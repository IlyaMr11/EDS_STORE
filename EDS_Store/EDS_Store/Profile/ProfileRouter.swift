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
    var navigationController: UINavigationController? { get }
    var AssemblyBuilder: ProfileAssemblyBuilderProtocol? { get }
    func initinal()
    func popToRoot()
}

class ProfileRouter: ProfileRouterProtocol {
    
    
    var AssemblyBuilder: ProfileAssemblyBuilderProtocol?
    var navigationController: UINavigationController?
    
    var profileAssemblyBuilder: ProfileAssemblyBuilderProtocol?
    
    init(navigationController: UINavigationController, profileAssemblyBuilder: ProfileAssemblyBuilderProtocol) {
        self.navigationController = navigationController
        self.profileAssemblyBuilder = profileAssemblyBuilder
    }
    
    func initinal() {
        if let navigationController = navigationController {
            guard let mainProfileView = profileAssemblyBuilder?.createMainProfileModule(router: self) else {return}
            navigationController.viewControllers = [mainProfileView]
        }
    }
    
    func popToRoot() {
        
    }
    
    func showSignInModule() {
        
    }
    
    func showRegistrationModule() {
        
    }
    
    func showUserInfoModule() {
        
    }
    
    func showDeliveryModule() {
        
    }
    
    func showHistoryModule() {
        
    }
    
}

