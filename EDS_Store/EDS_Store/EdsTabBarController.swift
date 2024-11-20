//
//  EdsTabBarController.swift
//  EDS_Store
//
//  Created by Илья Морозов on 20.11.2024.
//

import UIKit

class EdsTabBarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        self.tabBar.tintColor = .orange
        self.viewControllers = createAllNavigationControllers()
        // Do any additional setup after loading the view.
    }
    

    func createRegistationNavigationController() -> UINavigationController {
        let signViewController = SignViewController()
        let registrationNavigationController = UINavigationController(rootViewController: signViewController)
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
    
    func createAllNavigationControllers() -> [UINavigationController] {
        let homeNavigationController = createHomeNavigationController()
        let bagNavigationController = createBagNavigationController()
        let registrationNavigationController = createRegistationNavigationController()
        return [homeNavigationController, bagNavigationController, registrationNavigationController]
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
