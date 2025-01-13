//
//  CatalogViewController.swift
//  EDS_Store
//
//  Created by Илья Морозов on 19.11.2024.
//

import UIKit

protocol MainHomeViewProtocol: AnyObject {
    func success()
    func failure()
}

class MainHomeView: UIViewController, MainHomeViewProtocol {
    
    //MARK: - VIEWS
    
    private lazy var searchView: UIView = {
        let view = UIView()
        view.backgroundColor = .systemGray4
        view.layer.cornerRadius = 20
        return view
    }()
    
    private lazy var searchTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Поиск..."
        textField.backgroundColor = .systemGray4
        textField.delegate = self
        textField.textAlignment = .left
        return textField
    }()
    
    private lazy var findButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: "magnifyingglass")?.withTintColor(.orange), for: .normal)
        button.addTarget(self, action: #selector(searchProduct), for: .touchUpInside)
        button.imageView?.contentMode = .scaleAspectFit
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Главная"
    
    }
    
    func success() {
        
    }
    
    func failure() {
        
    }
    
    @objc func searchProduct() {
        
    }
}


extension MainHomeView: UITextFieldDelegate {
    func textFieldDidBeginEditing(_ textField: UITextField) {
        textField.resignFirstResponder()
    }
}
