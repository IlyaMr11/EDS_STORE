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
    let buttonsRadius = CGFloat(13)
    
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
    
    //MARK: TextFields
    private lazy var loginTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Логин"
        textField.borderStyle = .none
        textField.layer.cornerRadius = buttonsRadius
        textField.layer.borderWidth = 1.5
        textField.layer.borderColor = UIColor.black.cgColor
        textField.keyboardType = .emailAddress
        textField.clearButtonMode = .whileEditing
        return textField
    }()
    
    private lazy var passwordTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Пароль"
        textField.borderStyle = .none
        textField.layer.cornerRadius = buttonsRadius
        textField.layer.borderWidth = 1.5
        textField.layer.borderColor = UIColor.black.cgColor
        textField.isSecureTextEntry = true
        textField.clearButtonMode = .whileEditing
        return textField
    }()
    
    //MARK: - BUTTONS
    private lazy var siginButton: UIButton = {
        let button = UIButton()
        button.setTitle("Войти", for: .normal)
        button.backgroundColor = .black
        button.setTitleColor(.white, for: .normal)
        button.layer.cornerRadius = buttonsRadius
        return button
    }()
    
    private lazy var registrationButton: UIButton = {
        let button = UIButton()
        button.setTitle("Зарегистрироваться", for: .normal)
        button.backgroundColor = .orange
        button.setTitleColor(.black, for: .normal)
        button.layer.cornerRadius = buttonsRadius
        return button
    }()
    
    private lazy var orLabel: UILabel = {
        let label = UILabel()
        label.text = "или"
        label.textColor = .black
        label.font = .systemFont(ofSize: 20, weight: .semibold)
        label.textAlignment = .center
        return label
    }()
    
    //MARK: - StackViews
    private lazy var fieldsStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [loginTextField, passwordTextField])
        stackView.axis = .vertical
        stackView.spacing = view.bounds.width / 30
        stackView.distribution = .fillEqually
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    private lazy var buttonsStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [siginButton, orLabel, registrationButton])
        stackView.axis = .vertical
        stackView.distribution = .fillEqually
        stackView.spacing = 0
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
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
        setupFieldsStackView(fieldsStackView)
        setupButtonsStackView(buttonsStackView)
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
    
    func setupFieldsStackView(_ stackView: UIStackView) {
        view.addSubview(stackView)
        stackView.topAnchor.constraint(equalTo: borderView.topAnchor, constant: 10).isActive = true
        stackView.bottomAnchor.constraint(equalTo: borderView.bottomAnchor, constant: -view.bounds.height * 0.3).isActive = true
        stackView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        stackView.widthAnchor.constraint(equalToConstant: view.bounds.width * 0.72).isActive = true
    }
    
    func setupButtonsStackView(_ stackView: UIStackView) {
        view.addSubview(stackView)
        stackView.topAnchor.constraint(equalTo: fieldsStackView.bottomAnchor, constant: view.bounds.height * 0.05).isActive = true
        stackView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        stackView.widthAnchor.constraint(equalToConstant: view.bounds.width * 0.72).isActive = true
        stackView.bottomAnchor.constraint(equalTo: borderView.bottomAnchor, constant: -10).isActive = true
    }
    
    
    @objc func toRegistration() {
        let registrationViewController = RegistrationViewController()
        self.navigationController?.pushViewController(registrationViewController, animated: true)
    }
}

