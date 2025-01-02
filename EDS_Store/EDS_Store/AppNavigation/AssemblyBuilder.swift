//
//  ProfileAssemblyBuilder.swift
//  EDS_Store
//
//  Created by Илья Морозов on 02.01.2025.
//

import UIKit

protocol AssemblyBuilderProtocol {
    func createMainProfileModule(router: RouterProtocol) -> ViewController
}
