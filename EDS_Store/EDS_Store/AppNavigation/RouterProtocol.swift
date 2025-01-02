//
//  RouterProtocol.swift
//  EDS_Store
//
//  Created by Илья Морозов on 02.01.2025.
//

import UIKit

protocol RouterProtocol {
    var navigationController: UINavigationController { get set }
    var AssemblyBuilder: AssemblyBuilderProtocol? { get set }
    func inititalProtocol()
    func popToRoot()
}
