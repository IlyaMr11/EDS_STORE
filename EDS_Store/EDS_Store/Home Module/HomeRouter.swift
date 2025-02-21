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
    func showProductDetails(product: Product, image: UIImage)
}

class HomeRouter: HomeRouterProtocol {
    var navigationController: UINavigationController?
    var assemblyBuilder: HomeAssemblyBuilderProtocol?
    
    required init(navigationController: UINavigationController, assemblyBuilder: any HomeAssemblyBuilderProtocol) {
        self.assemblyBuilder = assemblyBuilder
        self.navigationController = navigationController
    }
    
    func initinal() {
        guard let navigationController, let mainHomeView = assemblyBuilder?.mainHomeModule(router: self) else { return }
        navigationController.viewControllers = [mainHomeView]
    }
    
    func showProductDetails(product: Product, image: UIImage) {
        guard let navigationController, let productPageView = assemblyBuilder?.productPageModule(router: self) else { return }
        productPageView.product = product
        productPageView.image = image
        navigationController.pushViewController(productPageView, animated: true)
    }
}
