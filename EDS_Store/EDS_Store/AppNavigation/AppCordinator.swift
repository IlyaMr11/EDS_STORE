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
    
    static var shared: AppCordinator!

    init(window: UIWindow?) {
        self.tabBarController = UITabBarController()
        self.window = window
        AppCordinator.shared = self // Сохраняем текущий экземпляр в shared
    }
    
    func showProfileModule() {
        tabBarController?.selectedIndex = 2
    }
    
    func showHomeModule() {
        tabBarController?.selectedIndex = 0
    }
    
    func showBagModule() {
        tabBarController?.selectedIndex = 1
    }
    
    func startCordinator() {
        tabBarController?.tabBar.tintColor = .orange
        let profileRouter = createProfileModule()
        let homeRouter = createHomeModule()
        let bagRouter = createBagModule()
        
        window?.rootViewController = tabBarController
        window?.makeKeyAndVisible()
        guard let profileNav = profileRouter.navigationController,
              let homeNav = homeRouter.navigationController,
              let bagNav = bagRouter.navigationController else  { return }
        
        //MARK: - WARNING
        tabBarController?.viewControllers = [homeNav, bagNav, profileNav]
        
    }
    
    func createProfileModule() -> ProfileRouterProtocol {
        let profileNavigationController = UINavigationController()
        profileNavigationController.title = "Профиль"
        profileNavigationController.tabBarItem.image = UIImage(systemName: "person.circle")
        profileNavigationController.setupNavBarAttrs()
        let profileAssemblyBuilder = ProfileAssemblyBuilder()
        let router = ProfileRouter(navigationController: profileNavigationController, profileAssemblyBuilder: profileAssemblyBuilder)
        router.initinal()
        return router
    }
    
    func createHomeModule() -> HomeRouterProtocol {
        let homeNavigationController = UINavigationController()
        homeNavigationController.title = "Главная"
        homeNavigationController.tabBarItem.image = UIImage(systemName: "house")
        homeNavigationController.setupNavBarAttrs()
        let homeAssemblyBuilder = HomeAssemblyBuilder()
        let router = HomeRouter(navigationController: homeNavigationController, assemblyBuilder: homeAssemblyBuilder)
        router.initinal()
        return router
    }
    
    func createBagModule() -> BagRouterProtocol {
        let bagNavigationController = UINavigationController()
        bagNavigationController.title = "Корзина"
        bagNavigationController.tabBarItem.image = UIImage(systemName: "basket")
        bagNavigationController.setupNavBarAttrs()
        let bagAssemblyBuilder = BagAssemblyBuilder()
        let router = BagRouter(navigationController: bagNavigationController, assemblyBuilder: bagAssemblyBuilder)
        router.initinal()
        return router
    }
}
