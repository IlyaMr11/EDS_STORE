//
//  EdsTabBarController.swift
//  EDS_Store
//
//  Created by Илья Морозов on 20.11.2024.
//
public var isSign = false

import UIKit

class EdsTabBarController: UITabBarController {

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tabBar.tintColor = .orange
        self.tabBar.backgroundColor = .white
        self.viewControllers = createAllNavigationControllers()
        // Do any additional setup after loading the view.
    }
    
    //MARK: - REG NAVIGATION CONTROL
    func createRegistationNavigationController() -> UINavigationController {
        let profileViewController = ProfileViewController()
        let registrationNavigationController = UINavigationController(rootViewController: profileViewController)
        registrationNavigationController.title = "Профиль"
        registrationNavigationController.tabBarItem.image = UIImage(systemName: "person")
        return registrationNavigationController
    }
    
    //MARK: - BAG NAVIGATION CONTROL
    func createBagNavigationController() -> UINavigationController {
        let bagViewController = BagViewController()
        let bagNavigationController = UINavigationController(rootViewController: bagViewController)
        bagNavigationController.tabBarItem.image = UIImage(systemName: "basket")
        bagNavigationController.title = "Корзина"
        return bagNavigationController
    }
    
    //MARK: - HOME NAVIGATION CONTROL
    func createHomeNavigationController() -> UINavigationController {
        let homeViewController = HomeViewController()
        let homeNavigationController = UINavigationController(rootViewController: homeViewController)
        homeNavigationController.tabBarItem.image = UIImage(systemName: "house")
        homeNavigationController.title = "Главная"
        return homeNavigationController
    }
    
    //MARK: - BO0K NAVIGATION CONTROL
    func createBookNavigationController() -> UINavigationController {
        let bookVC = BookViewController()
        let bookNavigationController = UINavigationController(rootViewController: bookVC)
        bookNavigationController.tabBarItem.image = UIImage(systemName: "book")
        bookNavigationController.title = "Справочник"
        return bookNavigationController
    }
    
    //MARK: - CREATE ALL NAVIG C
    func createAllNavigationControllers() -> [UIViewController] {
        let homeNavigationController = createHomeNavigationController()
        let bagNavigationController = createBagNavigationController()
        let registrationNavigationController = createRegistationNavigationController()
        let bookViewController = createBookNavigationController()
        return [homeNavigationController, bookViewController, bagNavigationController, registrationNavigationController]
    }
}
