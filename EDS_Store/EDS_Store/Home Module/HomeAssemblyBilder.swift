//
//  HomeAssemblyBilder.swift
//  EDS_Store
//
//  Created by Илья Морозов on 14.01.2025.
//

import UIKit

protocol HomeAssemblyBuilderProtocol {
    func mainHomeModule(router: HomeRouterProtocol) -> UIViewController
}

class HomeAssemblyBuilder: HomeAssemblyBuilderProtocol {
    func mainHomeModule(router: HomeRouterProtocol) -> UIViewController {
        let view = MainHomeView()
        let model = MainHomeModel()
        let presenter = MainHomePresenter(view: view, router: router, model: model)
        view.presenter = presenter
        return view
    }
}
