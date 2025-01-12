//
//  ProfileAssemblyBuilder.swift
//  EDS_Store
//
//  Created by Илья Морозов on 02.01.2025.
//
import UIKit

protocol ProfileAssemblyBuilderProtocol {
    func createMainProfileModule(router: ProfileRouterProtocol) -> UIViewController
    func createHistoryMoudle(router: ProfileRouterProtocol) -> UIViewController
    func createDeliveryModule(router: ProfileRouterProtocol) -> UIViewController
    func createSignInModule(router: ProfileRouterProtocol) -> UIViewController
    func createRegistrationModule(router: ProfileRouterProtocol) -> UIViewController
    func createUserInfoModule(router: ProfileRouterProtocol) -> UIViewController
}

class ProfileAssemblyBuilder: ProfileAssemblyBuilderProtocol {

    func createMainProfileModule(router: any ProfileRouterProtocol) -> UIViewController {
        let view = MainProfileView()
        let networkService = ProfileNetworkService()
        let model = MainProfileModel(networkService: networkService)
        let presenter = MainProfilePresenter(view: view, router: router, model:  model)
        view.presenter = presenter
        return view
    }
    
    func createHistoryMoudle(router: ProfileRouterProtocol) -> UIViewController {
        let view = HistoryView()
        let model = HistoryModel()
        let presenter = HistoryPresenter(view: view , router: router, model: model)
        view.presenter = presenter
        return view
    }
    
    func createDeliveryModule(router: any ProfileRouterProtocol) -> UIViewController {
        let view = DeliveryView()
        let model = DeliveryModel()
        let presenter = DeliveryPresenter(view: view, router: router, model: model)
        view.presenter = presenter
        return view
    }
    
    func createSignInModule(router: any ProfileRouterProtocol) -> UIViewController {
        let view = SignInView()
        let model = SignInModel(networkService: ProfileNetworkService())
        let presenter = SignInPresenter(view: view , router: router, model: model)
        view.presenter = presenter
        return view
    }
    
    func createRegistrationModule(router: any ProfileRouterProtocol) -> UIViewController {
        let view = RegistrationView()
        let model = RegistrationModel(networkService: ProfileNetworkService())
        let presenter = RegistrationPresenter(view: view , router: router, model: model)
        view.presenter = presenter
        return view
    }
    
    func createUserInfoModule(router: any ProfileRouterProtocol) -> UIViewController {
        let view = UserInfoView()
        let model = UserInfoModel()
        let presenter = UserInfoPresenter(model: model, router: router, view: view)
        view.presenter = presenter
        return view
    }


}
