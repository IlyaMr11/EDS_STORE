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

    init(tabBarController: UITabBarController, window: UIWindow) {
        self.tabBarController = tabBarController
        self.window = window
    }
    
    func startCordinator() {
    
    }
    
    func createProfileMoudule() {
        
    }
    
}
