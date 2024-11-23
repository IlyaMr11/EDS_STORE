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
    

    func createRegistationNavigationController() -> UINavigationController {
        let profileViewController = ProfileViewController()
        let registrationNavigationController = UINavigationController(rootViewController: profileViewController)
        registrationNavigationController.title = "Профиль"
        registrationNavigationController.tabBarItem.image = UIImage(systemName: "person")
        return registrationNavigationController
    }
    
    func createBagNavigationController() -> UINavigationController {
        let bagViewController = BagViewController()
        let bagNavigationController = UINavigationController(rootViewController: bagViewController)
        bagNavigationController.tabBarItem.image = UIImage(systemName: "basket")
        bagNavigationController.title = "Корзина"
        return bagNavigationController
    }
    
    func createHomeNavigationController() -> UINavigationController {
        let catalogViewController = CatalogViewController()
        let homeNavigationController = UINavigationController(rootViewController: catalogViewController)
        homeNavigationController.tabBarItem.image = UIImage(systemName: "house")
        homeNavigationController.title = "Главная"
        return homeNavigationController
    }
    
    func createAllNavigationControllers() -> [UIViewController] {
        let homeNavigationController = createHomeNavigationController()
        let bagNavigationController = createBagNavigationController()
        let registrationNavigationController = createRegistationNavigationController()
        let bookViewController = createBookEdsPrivod()
        return [homeNavigationController, bookViewController, bagNavigationController, registrationNavigationController]
    }
    
    func createBookEdsPrivod() -> UINavigationController {
        let bookVC = BookViewController()
        let bookNavigationController = UINavigationController(rootViewController: bookVC)
        bookNavigationController.tabBarItem.image = UIImage(systemName: "book")
        bookNavigationController.title = "Каталог"
        return bookNavigationController
    }
    /*
     
    // MARK: - Navigation
     

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
