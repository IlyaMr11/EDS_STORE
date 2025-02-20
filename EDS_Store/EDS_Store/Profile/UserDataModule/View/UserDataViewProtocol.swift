//
//  UserDataView.swift
//  EDS_Store
//
//  Created by Илья Морозов on 05.02.2025.
//

import UIKit


protocol UserDataViewProtocol: UIViewController {
    func saveData()
    func setupData(data: Any)
    func success()
    func failure(error: AlertType)
    var presenter: UserDataPresenterProtocol? { get set }
}


