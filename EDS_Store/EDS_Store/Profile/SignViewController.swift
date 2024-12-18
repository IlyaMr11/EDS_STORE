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
    let borderRadius = CGFloat(30)
    let buttonsRadius = CGFloat(15)
    
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
        label.textColor = .black
        label.numberOfLines = 0
        label.font = .boldSystemFont(ofSize: 24)
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    //MARK: BORDER
    private lazy var borderView: UIView = {
        let view = UIView()
        view.layer.borderWidth = 2.5
        view.layer.borderColor = UIColor.black.cgColor
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
        textField.layer.borderColor = UIColor.orange.cgColor
        textField.keyboardType = .emailAddress
        textField.clearButtonMode = .whileEditing
        textField.delegate = self
        return textField
    }()
    
    private lazy var passwordTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Пароль"
        textField.borderStyle = .none
        textField.layer.cornerRadius = buttonsRadius
        textField.layer.borderWidth = 1.5
        textField.layer.borderColor = UIColor.orange.cgColor
        textField.isSecureTextEntry = true
        textField.clearButtonMode = .whileEditing
        textField.delegate = self
        return textField
    }()
    
    //MARK: - BUTTONS
    private lazy var siginButton: UIButton = {
        let button = UIButton()
        button.setTitle("Войти", for: .normal)
        button.backgroundColor = .black
        button.setTitleColor(.white, for: .normal)
        button.layer.cornerRadius = buttonsRadius
        button.addTarget(self, action: #selector(toProfile), for: .touchUpInside)
        return button
    }()
    
    private lazy var registrationButton: UIButton = {
        let button = UIButton()
        button.setTitle("Зарегистрироваться", for: .normal)
        button.backgroundColor = .orange
        button.setTitleColor(.black, for: .normal)
        button.layer.cornerRadius = buttonsRadius
        button.addTarget(self, action: #selector(toRegistration), for: .touchUpInside)
        return button
    }()
    
    //MARK: - или LABEL
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
    
    //MARK: - SETUP LOGO
    func setupLogo(_ imageView: UIImageView) {
        view.addSubview(imageView)
        imageView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        imageView.widthAnchor.constraint(equalToConstant: view.bounds.width * 0.45).isActive = true
        imageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20).isActive = true
        imageView.heightAnchor.constraint(equalToConstant: view.bounds.height * 0.125).isActive = true
    }
    
    //MARK: SETUP WELCOM
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
        border.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -5).isActive = true
        border.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        border.widthAnchor.constraint(equalToConstant: view.bounds.width * 0.825).isActive = true
    }
    
    //MARK: SETUP StackViews
    func setupFieldsStackView(_ stackView: UIStackView) {
        view.addSubview(stackView)
        stackView.topAnchor.constraint(equalTo: borderView.topAnchor, constant: 20).isActive = true
        stackView.heightAnchor.constraint(equalToConstant: view.bounds.height * 0.16).isActive = true
        stackView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        stackView.widthAnchor.constraint(equalToConstant: view.bounds.width * 0.7).isActive = true
    }
    
    func setupButtonsStackView(_ stackView: UIStackView) {
        view.addSubview(stackView)
        stackView.heightAnchor.constraint(equalToConstant: view.bounds.height * 0.225).isActive = true
        stackView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        stackView.widthAnchor.constraint(equalToConstant: view.bounds.width * 0.7).isActive = true
        stackView.bottomAnchor.constraint(equalTo: borderView.bottomAnchor, constant: -20).isActive = true
    }
    
    
    //MARK: - TARGETS
    @objc func toRegistration() {
        let registrationViewController = RegistrationViewController()
        self.navigationController?.pushViewController(registrationViewController, animated: true)
    }
    
    @objc func toProfile() {
        isSign = true
        if checkAllFields() {
            let profileViewController = ProfileViewController()
            self.navigationController?.pushViewController(profileViewController, animated: true)
        }
    }
    
    func checkAllFields() -> Bool {
        if !checkAll.checkEmail(loginTextField.text) {
            showAlert(alert: allAlerts.emailAlert)
            return false
        } else if !checkAll.checkPassword(passwordTextField.text) {
            showAlert(alert: allAlerts.passwordAlert)
            return false
        }
        return true
    }
    
    //MARK: - SHOW ALERTS
    func showAlert(alert: UIAlertController) {
        present(alert, animated: true)
    }
}

//EXTENSION
extension SignViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
}
