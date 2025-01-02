//
//  ProfileAssemblyBuilder.swift
//  EDS_Store
//
//  Created by Илья Морозов on 02.01.2025.
//

protocol ProfileAssemblyBuilderProtocol {
    func createHistoryMoudle(router: ProfileRouterProtocol)
    func createDeliveryModule(router: RouterProtocol)
    func createSignInModule(router: RouterProtocol)
    func createRegistrationModule(router: RouterProtocol)
    func createUserInfoModule(router: RouterProtocol)
}

class ProfileAssemblyBuilder: ProfileAssemblyBuilderProtocol, AssemblyBuilderProtocol {
    
    func createMainProfileModule(router: any RouterProtocol) -> ViewController {
        let view = MainProfileView()
        let getNetworkService = GetNetworkService()
        let presenter = MainProfilePresenter(view: view, router: router, networkService:  getNetworkService)
        view.presenter = presenter
    }
    
    func createHistoryMoudle(router: ProfileRouterProtocol) {
        <#code#>
    }
    
    func createDeliveryModule(router: RouterProtocol) {
        <#code#>
    }
    
    func createSignInModule(router: RouterProtocol) {
        <#code#>
    }
    
    func createRegistrationModule(router: RouterProtocol) {
        <#code#>
    }
    
    func createUserInfoModule(router: RouterProtocol) {
        <#code#>
    }

    
}
