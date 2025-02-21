//
//  BagRouter.swift
//  EDS_Store
//
//  Created by Илья Морозов on 19.01.2025.
//

import UIKit

protocol BagRouterProtocol {
    var navigationController: UINavigationController? { get set }
    var assemblyBuilder: BagAssemblyBuilderProtocol? { get set }
    init(navigationController: UINavigationController, assemblyBuilder: BagAssemblyBuilderProtocol)
    func initinal()
}

class BagRouter: BagRouterProtocol {
    
    var assemblyBuilder: (any BagAssemblyBuilderProtocol)?
    var navigationController: UINavigationController?
    
    required init(navigationController: UINavigationController, assemblyBuilder: any BagAssemblyBuilderProtocol) {
        self.assemblyBuilder = assemblyBuilder
        self.navigationController = navigationController
    }
    
    func initinal() {
        guard let nav = navigationController,
        let bagView = assemblyBuilder?.bagModule(router: self) else { return }
        nav.pushViewController(bagView, animated: true)
    }
    
    
}
