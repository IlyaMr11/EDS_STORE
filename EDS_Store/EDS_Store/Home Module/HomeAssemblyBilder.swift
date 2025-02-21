//
//  HomeAssemblyBilder.swift
//  EDS_Store
//
//  Created by Илья Морозов on 14.01.2025.
//

import UIKit

protocol HomeAssemblyBuilderProtocol {
    func mainHomeModule(router: HomeRouterProtocol) -> UIViewController
    func productPageModule(router: HomeRouterProtocol) -> ProductPageViewProtocol
}

class HomeAssemblyBuilder: HomeAssemblyBuilderProtocol {
    func productPageModule(router: any HomeRouterProtocol) -> ProductPageViewProtocol {
        let view = ProductPageView()
        let model = ProductPageModel()
        let presenter = ProductPagePresenter(view: view, router: router, model: model)
        view.presenter = presenter
        return view
    }
    
    func mainHomeModule(router: HomeRouterProtocol) -> UIViewController {
        let view = MainHomeView()
        let model = MainHomeModel(firebaseService: HomeFirebaseService.shared)
        let presenter = MainHomePresenter(view: view, router: router, model: model)
        view.presenter = presenter
        return view
    }
}
