//
//  AppCordinator.swift
//  EDS_Store
//
//  Created by Илья Морозов on 02.01.2025.
//

import UIKit

protocol CordinatorProtocol {
    var tabBarController: UITabBarController? { get set }
    var window: UIWindow? { get set }
}


class AppCordinator: CordinatorProtocol {
    var tabBarController: UITabBarController?
    var window: UIWindow?

    init(window: UIWindow?) {
        self.tabBarController = UITabBarController()
        self.window = window
    }
    
    func startCordinator() {
        let profileRouter = createProfileModule()
        if let profileNav = profileRouter.navigationController {
            tabBarController?.viewControllers = [profileNav]
        }
        //MARK: - WARNING
        window?.rootViewController = tabBarController
        window?.makeKeyAndVisible()
    }
    
    func createProfileModule() -> ProfileRouterProtocol {
        let profileNavigationController = UINavigationController()
        let profileAssemblyBuilder = ProfileAssemblyBuilder()
        let router = ProfileRouter(navigationController: profileNavigationController, profileAssemblyBuilder: profileAssemblyBuilder)
        router.initinal()
        return router
    }
    
}
