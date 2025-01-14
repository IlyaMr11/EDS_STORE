//
//  HomeRouter.swift
//  EDS_Store
//
//  Created by Илья Морозов on 12.01.2025.
//

import UIKit

protocol HomeRouterProtocol {
    var navigationController: UINavigationController? { get }
    var assemblyBuilder: HomeAssemblyBuilderProtocol? { get }
    init(navigationController: UINavigationController, assemblyBuilder: HomeAssemblyBuilderProtocol)
    func initinal()
}

class HomeRouter: HomeRouterProtocol {
    var navigationController: UINavigationController?
    var assemblyBuilder: HomeAssemblyBuilderProtocol?
    
    required init(navigationController: UINavigationController, assemblyBuilder: any HomeAssemblyBuilderProtocol) {
        self.assemblyBuilder = assemblyBuilder
        self.navigationController = navigationController
    }
    
    func initinal() {
        guard let navigationController, let homeViewController = assemblyBuilder?.mainHomeModule(router: self) else { return }
        navigationController.viewControllers = [homeViewController]
    }
}
