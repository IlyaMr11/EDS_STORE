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
        tabBarController?.tabBar.tintColor = .orange
        let profileRouter = createProfileModule()
        let homeRouter = createHomeModule()
        if let profileNav = profileRouter.navigationController, let homeNav = homeRouter.navigationController {
            tabBarController?.viewControllers = [homeNav, profileNav]
        }
        //MARK: - WARNING
        window?.rootViewController = tabBarController
        window?.makeKeyAndVisible()
    }
    
    func createProfileModule() -> ProfileRouterProtocol {
        let profileNavigationController = UINavigationController()
        profileNavigationController.tabBarItem.image = UIImage(systemName: "person.circle")
        let profileAssemblyBuilder = ProfileAssemblyBuilder()
        let router = ProfileRouter(navigationController: profileNavigationController, profileAssemblyBuilder: profileAssemblyBuilder)
        router.initinal()
        return router
    }
    
    func createHomeModule() -> HomeRouterProtocol {
        let homeNavigationController = UINavigationController()
        homeNavigationController.tabBarItem.image = UIImage(systemName: "house")
        let homeAssemblyBuilder = HomeAssemblyBuilder()
        let router = HomeRouter(navigationController: homeNavigationController, assemblyBuilder: homeAssemblyBuilder)
        router.initinal()
        return router
    }
}
