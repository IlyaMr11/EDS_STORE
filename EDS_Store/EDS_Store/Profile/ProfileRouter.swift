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
    var navigationController: UINavigationController? { get }
    var assemblyBuilder: ProfileAssemblyBuilderProtocol? { get }
    func initinal()
    func popToRoot()
    func showUserDataModule(index: Int)
}

class ProfileRouter: ProfileRouterProtocol {
    
    
    var assemblyBuilder: ProfileAssemblyBuilderProtocol?
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
    
    
    func showUserDataModule(index: Int) {
        if let navigationController = navigationController {
            guard let userDataView = profileAssemblyBuilder?.createUserDataModule(router: self, index: index) else {return}
            switch index {
            case 0...1:
                navigationController.pushViewController(userDataView, animated: true)
            default:
                navigationController.showDetailViewController(userDataView, sender: nil)
            }
            
        }
    }
    
}

