//
//  ViewController.swift
//  EDS_Store
//
//  Created by Илья Морозов on 11.11.2024.
//

import UIKit

class   SignViewController: UIViewController {

    private lazy var registrationButton: UIButton = {
        let button = UIButton()
        button.frame = CGRect(x: 50, y: 100, width: 100, height: 100)
        button.backgroundColor = .orange
        button.setTitle("Зарегистрироваться", for: .normal)
        button.addTarget(self, action: #selector(toRegistration), for: .touchUpInside)
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Вход"
        view.backgroundColor = .red
        view.addSubview(registrationButton)
        // Do any additional setup after loading the view.
    }

    @objc func toRegistration() {
        let registrationViewController = RegistrationViewController()
        self.navigationController?.pushViewController(registrationViewController, animated: true)
    }
}

