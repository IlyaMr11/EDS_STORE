//
//  ViewController.swift
//  EDS_Store
//
//  Created by Илья Морозов on 11.11.2024.
//

import UIKit

class   SignViewController: UIViewController {
    
    //MARK: - CONSTANTS
    //radiuses
    let borderRadius = CGFloat(15)
    
    //MARK: - LOGO
    private lazy var logoImageView: UIImageView = {
        let imageView = UIImageView(image: UIImage(named: "logo7"))
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    //MARK: - LABEL
    private lazy var welcomeLabel: UILabel = {
        let label = UILabel()
        label.text = "Войдите или зарегистрируйтесь"
        label.numberOfLines = 0
        label.font = .boldSystemFont(ofSize: 24)
        label.textColor = .black
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var borderView: UIView = {
        let view = UIView()
        view.layer.borderWidth = 2
        view.layer.borderColor = UIColor.orange.cgColor
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.cornerRadius = borderRadius
        return view
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Вход"
        view.backgroundColor = .white
        setupAllViews()
        // Do any additional setup after loading the view.
    }

    func setupAllViews() {
        setupLogo(logoImageView)
        setupWelcomLabel(welcomeLabel)
        setupBorder(borderView)
    }
    func setupLogo(_ imageView: UIImageView) {
        view.addSubview(imageView)
        imageView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        imageView.widthAnchor.constraint(equalToConstant: 200).isActive = true
        imageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20).isActive = true
        imageView.heightAnchor.constraint(equalToConstant: 120).isActive = true
    }
    
    func setupWelcomLabel(_ label: UILabel) {
        view.addSubview(label)
        label.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -view.bounds.width * 0.2).isActive = true
        label.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: view.bounds.width * 0.2).isActive = true
        label.topAnchor.constraint(equalTo: logoImageView.bottomAnchor, constant: 5).isActive = true
        label.heightAnchor.constraint(equalToConstant: view.bounds.height * 0.15).isActive = true
    }
    
    func setupBorder(_ border: UIView) {
        view.addSubview(border)
        border.topAnchor.constraint(equalTo: welcomeLabel.bottomAnchor).isActive = true
        border.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -25).isActive = true
        border.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        border.widthAnchor.constraint(equalToConstant: view.bounds.width * 0.8).isActive = true
    }
    
    @objc func toRegistration() {
        let registrationViewController = RegistrationViewController()
        self.navigationController?.pushViewController(registrationViewController, animated: true)
    }
}

