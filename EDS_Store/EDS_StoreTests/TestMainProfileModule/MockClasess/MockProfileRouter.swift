//
//  MockProfileRouter.swift
//  EDS_StoreTests
//
//  Created by Илья Морозов on 18.02.2025.
//

import UIKit

@testable import EDS_Store

class MockProfileRouter: ProfileRouterProtocol {
    var index: Int?
    
    func popView() {
        print("popView")
    }
    
    func showSignInModule() {
        print("showSignInModule")
    }
    
    func showRegistrationModule() {
        print("showRegistrationModule")
    }
    
    func showUserInfoModule() {
        print("showUserInfoModule")
    }
    
    var navigationController: UINavigationController?
    
    var assemblyBuilder: (any EDS_Store.ProfileAssemblyBuilderProtocol)?
    
    func initinal() {
        print("initinal")
    }
    
    func popToRoot() {
        print("popToRoot")
    }
    
    func showUserDataModule(index: Int) {
        self.index = index
    }
}
