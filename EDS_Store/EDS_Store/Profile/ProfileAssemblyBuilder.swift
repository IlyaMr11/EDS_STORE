//
//  ProfileAssemblyBuilder.swift
//  EDS_Store
//
//  Created by Илья Морозов on 02.01.2025.
//
import UIKit

protocol ProfileAssemblyBuilderProtocol {
    func createMainProfileModule(router: ProfileRouterProtocol) -> UIViewController
    func createHistoryMoudle(router: ProfileRouterProtocol)
    func createDeliveryModule(router: ProfileRouterProtocol)
    func createSignInModule(router: ProfileRouterProtocol) -> UIViewController
    func createRegistrationModule(router: ProfileRouterProtocol)
    func createUserInfoModule(router: ProfileRouterProtocol)
}

class ProfileAssemblyBuilder: ProfileAssemblyBuilderProtocol {

    func createMainProfileModule(router: any ProfileRouterProtocol) -> UIViewController {
        let view = MainProfileView()
        let profileNetworkService = ProfileNetworkService()
        let presenter = MainProfilePresenter(view: view, router: router, networkService:  profileNetworkService)
        view.presenter = presenter
        return view
    }
    
    func createHistoryMoudle(router: ProfileRouterProtocol) {
        
    }
    
    func createDeliveryModule(router: any ProfileRouterProtocol) {
        
    }
    
    func createSignInModule(router: any ProfileRouterProtocol) -> UIViewController {
        let view = SignInView()
        let model = SignInModel()
        let presenter = SignInPresenter(view: view , router: router, model: model)
        view.presenter = presenter
        return view
    }
    
    func createRegistrationModule(router: any ProfileRouterProtocol) {
        
    }
    
    func createUserInfoModule(router: any ProfileRouterProtocol) {
        
    }

    
}
