//
//  MockBuilder.swift
//  EDS_StoreTests
//
//  Created by Илья Морозов on 18.02.2025.
//

import UIKit
@testable import EDS_Store

class MockProfileAssemblyBuilder: ProfileAssemblyBuilderProtocol {
    func createMainProfileModule(router: any EDS_Store.ProfileRouterProtocol) -> UIViewController {
        return UIViewController()
    }
    
    func createSignInModule(router: any EDS_Store.ProfileRouterProtocol) -> UIViewController {
        return UIViewController()
    }
    
    func createRegistrationModule(router: any EDS_Store.ProfileRouterProtocol) -> UIViewController {
        return UIViewController()
    }
    
    
    func createUserInfoModule(router: any EDS_Store.ProfileRouterProtocol) -> UIViewController {
        return UIViewController()
    }
    
    func createUserDataModule(router: any EDS_Store.ProfileRouterProtocol, index: Int) -> UIViewController {
        return UIViewController()
    }
}
