//
//  ProfileRouter.swift
//  EDS_Store
//
//  Created by Илья Морозов on 02.01.2025.
//

import UIKit


protocol ProfileRouterProtocol {
    func popView()
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
    
    func popView() {
        if let navigationController = navigationController {
            navigationController.popViewController(animated: true)
        }
    }
    func showSignInModule() {
        if let navigationController = navigationController {
            guard let signInView = profileAssemblyBuilder?.createSignInModule(router: self) else {return}
            navigationController.pushViewController(signInView, animated: true)
        }
    }
    
    func showRegistrationModule() {
        if let navigationController = navigationController {
            guard let regstrationView = profileAssemblyBuilder?.createRegistrationModule(router: self) else {return}
            navigationController.pushViewController(regstrationView, animated: true)
        }
    }
    
    func showUserInfoModule() {
        if let navigationController = navigationController {
            guard let userInfoView = profileAssemblyBuilder?.createUserInfoModule(router: self) else {return}
            navigationController.pushViewController(userInfoView, animated: true)
        }
    }
    
    func showDeliveryModule() {
        if let navigationController = navigationController {
            guard let deliveryView = profileAssemblyBuilder?.createDeliveryModule(router: self) else {return}
            navigationController.pushViewController(deliveryView, animated: true)
        }
    }
    
    func showHistoryModule() {
        if let navigationController = navigationController {
            guard let historyView = profileAssemblyBuilder?.createHistoryMoudle(router: self) else {return}
            navigationController.pushViewController(historyView, animated: true)
        }
    }
    
}

