//
//  BagAssemblyBuilder.swift
//  EDS_Store
//
//  Created by Илья Морозов on 19.01.2025.
//

import UIKit

protocol BagAssemblyBuilderProtocol {
    func bagModule(router: BagRouterProtocol) -> UIViewController
    func confirmModule(router: BagRouterProtocol) -> UIViewController
}

class BagAssemblyBuilder: BagAssemblyBuilderProtocol {
    func bagModule(router: any BagRouterProtocol) -> UIViewController {
        let view = BagView()
        let model = BagModel()
        let presenter = BagPresenter(view: view, router: router, model: model)
        view.presenter = presenter
        return view
    }
    
    func confirmModule(router: BagRouterProtocol) -> UIViewController {
        let view = ConfirmView()
        let model = ConfirmModel()
        let presenter = ConfirmPresenter(view: view, router: router, model: model)
        view.presenter = presenter
        return view
    }
    
}
