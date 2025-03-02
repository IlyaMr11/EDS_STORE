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
    func confirmModule()
}

class BagRouter: BagRouterProtocol {
    
    //MARK: - PROPERTIES
    
    var assemblyBuilder: (any BagAssemblyBuilderProtocol)?
    var navigationController: UINavigationController?
    
    required init(navigationController: UINavigationController, assemblyBuilder: any BagAssemblyBuilderProtocol) {
        self.assemblyBuilder = assemblyBuilder
        self.navigationController = navigationController
    }
    
    //MARK: - PROTOCOL METHODS
    
    func initinal() {
        guard let nav = navigationController,
        let bagView = assemblyBuilder?.bagModule(router: self) else { return }
        nav.viewControllers = [bagView]
    }
    
    func confirmModule() {
        guard let nav = navigationController else { return }
        guard let confirmView = assemblyBuilder?.confirmModule(router: self) else { return }
        nav.pushViewController(confirmView, animated: true)
    }
    
}
