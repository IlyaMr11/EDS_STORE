//
//  ProfileAssemblyBuilder.swift
//  EDS_Store
//
//  Created by Илья Морозов on 02.01.2025.
//
import UIKit

protocol ProfileAssemblyBuilderProtocol {
    func createMainProfileModule(router: ProfileRouterProtocol) -> UIViewController
    func createSignInModule(router: ProfileRouterProtocol) -> UIViewController
    func createRegistrationModule(router: ProfileRouterProtocol) -> UIViewController
    func createUserInfoModule(router: ProfileRouterProtocol) -> UIViewController
    func createUserDataModule(router: ProfileRouterProtocol, index: Int) -> UIViewController
}

class ProfileAssemblyBuilder: ProfileAssemblyBuilderProtocol {

    func createMainProfileModule(router: any ProfileRouterProtocol) -> UIViewController {
        let view = MainProfileView()
        let model = MainProfileModel(networkService: ProfileNetworkService.shared)
        let presenter = MainProfilePresenter(view: view, router: router, model:  model)
        view.presenter = presenter
        return view
    }
    
    func createSignInModule(router: any ProfileRouterProtocol) -> UIViewController {
        let view = SignInView()
        let model = SignInModel(networkService: ProfileNetworkService.shared)
        let presenter = SignInPresenter(view: view , router: router, model: model)
        view.presenter = presenter
        return view
    }
    
    func createRegistrationModule(router: any ProfileRouterProtocol) -> UIViewController {
        let view = RegistrationView()
        let model = RegistrationModel()
        let presenter = RegistrationPresenter(view: view, router: router, model: model)
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

    func createUserDataModule(router: ProfileRouterProtocol, index: Int) -> UIViewController {
        let array = [DeliveryView.self, HistoryView.self, PayView.self, NameView.self, PhoneView.self, AddressView.self, NotificationView.self]
        let view = array[index].init() as! UserDataViewProtocol
        let model = UserDataModel()
        let presenter = UserDataPresenter(view: view, model: model, router: router)
        view.presenter = presenter
        return view
    }
}
