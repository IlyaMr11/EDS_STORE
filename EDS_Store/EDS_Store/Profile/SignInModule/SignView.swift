//
//  ViewController.swift
//  EDS_Store
//
//  Created by Илья Морозов on 11.11.2024.
//

import UIKit

protocol SignInViewProtocol: UIViewController {
    func failure(alert: AlertType)
}

class SignInView: UIViewController, SignInViewProtocol {
    
    //MARK: - CONSTANTS
    //radiuses
    let borderRadius = CGFloat(30)
    let buttonsRadius = CGFloat(15)
    var textIsHidden = false
    
    var presenter: SignInPresenterProtocol?
    
    private var loginView = UIView()
    
    private var passwordView = UIView()
    
    //MARK: - LOGO
    private lazy var logoImageView: UIImageView = {
        let imageView = UIImageView(image: UIImage(named: "logo7"))
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    var eyeButton = UIButton()
    
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
        view.layer.borderWidth = 3
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
        textField.keyboardType = .emailAddress
        textField.clearButtonMode = .whileEditing
        textField.delegate = self
        return textField
    }()
    
    private lazy var passwordTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Пароль"
        textField.borderStyle = .none
        //textField.isSecureTextEntry = true
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
        button.addTarget(self, action: #selector(toProfile(sender:)), for: .touchUpInside)
        button.addTarget(ButtonAnimations.shared, action: #selector(ButtonAnimations.comeback(sender:)), for: .touchUpInside)
        button.addTarget(ButtonAnimations.shared, action: #selector(ButtonAnimations.littleAndAlpha(sender:)), for: .touchDown)
        return button
    }()
    
    private lazy var registrationButton: UIButton = {
        let button = UIButton()
        button.setTitle("Зарегистрироваться", for: .normal)
        button.backgroundColor = .orange
        button.setTitleColor(.black, for: .normal)
        button.layer.cornerRadius = buttonsRadius
        button.addTarget(self, action: #selector(toRegistration(sender: )), for: .touchUpInside)
        button.addTarget(ButtonAnimations.shared, action: #selector(ButtonAnimations.comeback(sender:)), for: .touchUpInside)
        button.addTarget(ButtonAnimations.shared, action: #selector(ButtonAnimations.littleAndAlpha(sender:)), for: .touchDown)
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
    
    //MARK: - StackView
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
        self.navigationItem.largeTitleDisplayMode = .never
        setupAllViews()
        // Do any additional setup after loading the view.
    }
    
    func failure(alert: AlertType) {
        showAlert(alert.alert)
    }
    
    func setupAllViews() {
        setupLogo(logoImageView)
        setupWelcomLabel(welcomeLabel)
        setupBorder(borderView)
        setupButtonsStackView(buttonsStackView)
        setupLoginView()
        setupPasswordView()
    }
    
    func showAlert(_ alert: UIAlertController) {
        present(alert, animated: true)
    }
    
    
    //MARK: - SETUP LOGO
    func setupLogo(_ imageView: UIImageView) {
        view.addSubview(imageView)
        imageView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        imageView.widthAnchor.constraint(equalToConstant: view.bounds.width * 0.45).isActive = true
        imageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: view.frame.height / 37).isActive = true
        imageView.heightAnchor.constraint(equalToConstant: view.bounds.height * 0.125).isActive = true
    }
    
    //MARK: SETUP WELCOM
    func setupWelcomLabel(_ label: UILabel) {
        view.addSubview(label)
        label.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -view.bounds.width * 0.2).isActive = true
        label.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: view.bounds.width * 0.2).isActive = true
        label.topAnchor.constraint(equalTo: logoImageView.bottomAnchor, constant: 0).isActive = true
        label.heightAnchor.constraint(equalToConstant: view.bounds.height * 0.12).isActive = true
    }
    
    func setupBorder(_ border: UIView) {
        view.addSubview(border)
        border.topAnchor.constraint(equalTo: welcomeLabel.bottomAnchor, constant: 15).isActive = true
        border.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -10).isActive = true
        border.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        border.widthAnchor.constraint(equalToConstant: view.bounds.width * 0.825).isActive = true
    }
    
    //MARK: SETUP StackView
    func setupButtonsStackView(_ stackView: UIStackView) {
        view.addSubview(stackView)
        stackView.heightAnchor.constraint(equalToConstant: view.bounds.height * 0.225).isActive = true
        stackView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        stackView.rightAnchor.constraint(equalTo: borderView.rightAnchor, constant: -20).isActive = true
        stackView.bottomAnchor.constraint(equalTo: borderView.bottomAnchor, constant: -15).isActive = true
    }
    
    func setupLoginView() {
        loginView.layer.cornerRadius = buttonsRadius
        loginView.backgroundColor = .systemGray6
        loginView.layer.borderWidth = 2
        loginView.layer.borderColor = UIColor.orange.cgColor
        
        view.addSubview(loginView)
        loginView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            loginView.topAnchor.constraint(equalTo: borderView.topAnchor, constant: 15),
            loginView.rightAnchor.constraint(equalTo: borderView.rightAnchor, constant: -20),
            loginView.heightAnchor.constraint(equalToConstant: view.bounds.height * 0.075),
            loginView.leadingAnchor.constraint(equalTo: borderView.leadingAnchor, constant: 20)
            ])
        setupLoginTextField()
    }
    
    func setupPasswordView() {
        passwordView.layer.cornerRadius = buttonsRadius
        passwordView.backgroundColor = .systemGray6
        passwordView.layer.borderWidth = 2
        passwordView.layer.borderColor = UIColor.orange.cgColor
        
        
        view.addSubview(passwordView)
        passwordView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            passwordView.topAnchor.constraint(equalTo: loginView.bottomAnchor, constant: 20),
            passwordView.rightAnchor.constraint(equalTo: borderView.rightAnchor, constant: -20),
            passwordView.leftAnchor.constraint(equalTo: borderView.leftAnchor, constant: 20),
            passwordView.heightAnchor.constraint(equalToConstant: view.bounds.height * 0.075)
        ])
        
        setupPasswordTextField()
        setupEyeButton()
    }
    
    func setupLoginTextField() {
        loginView.addSubview(loginTextField)
        loginTextField.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            loginTextField.topAnchor.constraint(equalTo: loginView.topAnchor, constant: 5),
            loginTextField.leadingAnchor.constraint(equalTo: loginView.leadingAnchor, constant: 10),
            loginView.trailingAnchor.constraint(equalTo: loginTextField.trailingAnchor, constant: 10),
            loginTextField.bottomAnchor.constraint(equalTo: loginView.bottomAnchor, constant: -5)
        ])
    }
    
    func setupPasswordTextField() {
        passwordView.addSubview(passwordTextField)
        passwordTextField.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            passwordTextField.topAnchor.constraint(equalTo: passwordView.topAnchor, constant: 5),
            passwordTextField.leadingAnchor.constraint(equalTo: passwordView.leadingAnchor, constant: 10),
            passwordTextField.trailingAnchor.constraint(equalTo: passwordView.trailingAnchor, constant: -90),
            passwordTextField.bottomAnchor.constraint(equalTo: passwordView.bottomAnchor, constant: -5)
        ])
    }
    
    func setupEyeButton() {
        eyeButton.setImage(UIImage(systemName: "eye.slash"), for: .normal)
        eyeButton.layer.cornerRadius = 5
        eyeButton.backgroundColor = .white
        eyeButton.tintColor = .black
        eyeButton.addTarget(self, action: #selector(showPassword), for: .touchUpInside)
        passwordView.addSubview(eyeButton)
        
        eyeButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            eyeButton.centerYAnchor.constraint(equalTo: passwordView.centerYAnchor),
            eyeButton.trailingAnchor.constraint(equalTo: passwordView.trailingAnchor, constant: -10),
            eyeButton.topAnchor.constraint(equalTo: passwordView.topAnchor, constant: 10),
            eyeButton.leadingAnchor.constraint(equalTo: passwordTextField.trailingAnchor, constant: 20)
        ])
    }
    
    
    //MARK: - TARGETS
    @objc func toRegistration(sender: UIButton) {
        ButtonAnimations.growSize(layer: sender.layer)
        self.presenter?.toRegistation()
    }
    
    @objc func toProfile(sender: UIButton) {
        ButtonAnimations.growSize(layer: sender.layer)
        if let login = loginTextField.text, let password = passwordTextField.text {
            presenter?.toMainProfile(login: login, password: password)
        }
    }
    
    @objc func showPassword() {
        textIsHidden.toggle()
        passwordTextField.isSecureTextEntry = textIsHidden
        let imageName = textIsHidden ? "eye" : "eye.slash"
        eyeButton.setImage(UIImage(systemName: imageName), for: .normal)
    }
    
}

//EXTENSION
extension SignInView: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
}

