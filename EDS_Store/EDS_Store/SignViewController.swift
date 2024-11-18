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
    let borderRadius = CGFloat(25)
    let buttonsRadius = CGFloat(15)
    
    //regex for password
    let pasRegex1 = try! NSRegularExpression(pattern: "[0-9]+")
    let pasRegex2 = try! NSRegularExpression(pattern: "[a-z]+")
    let pasRegex3 = try! NSRegularExpression(pattern: "[A-Z]+")
    let pasRegex4 = try! NSRegularExpression(pattern: "[!+?.,#-]+")
    
    //regex for login
    let loginRegex = try! NSRegularExpression(pattern: "[a-zA-z0-9]+@[a-zA-Z0-9]+\\.[a-zA-Z0-9]+")
    
    
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
        imageView.widthAnchor.constraint(equalToConstant: 200).isActive = true
        imageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20).isActive = true
        imageView.heightAnchor.constraint(equalToConstant: 120).isActive = true
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
        let b1 = checkLogin(loginTextField.text)
        let b2 = checkPassword(passwordTextField.text)
        if b1 && b2 {
            let profileViewController = ProfileViewController()
            self.navigationController?.pushViewController(profileViewController, animated: true)
        }
    }
    //MARK: - CHECK IS CORRECT?
    func checkPassword(_ text: String?) -> Bool {
        guard let text = text else { return false }
        let passordRegexes = [pasRegex1, pasRegex2, pasRegex3, pasRegex4]
        let range = NSRange(location: 0, length: text.utf16.count)
        for regex in passordRegexes {
            if !(regex.firstMatch(in: text, options: [], range: range) != nil) {
                showPassordAlert()
                return false
            }
        }
        return true
    }
    
    func checkLogin(_ text: String?) -> Bool {
        guard let text = text else { return false }
        let range = NSRange(location: 0, length: text.utf16.count)
        if !(loginRegex.firstMatch(in: text, range: range) != nil) {
            showLoginALert()
            return false
        }
        return true
    }
    
    //MARK: - SHOW ALERTS
    func showPassordAlert() {
        let alert = UIAlertController(title: "Неккоректный пароль", message: "Попробуйте новый пароль", preferredStyle: .alert)
        let action = UIAlertAction(title: "OK", style: .cancel)
        alert.addAction(action)
        present(alert, animated: true)
    }
    
    func showLoginALert() {
        let alert = UIAlertController(title: "Неверный логин", message: "Попробуйте другой логин", preferredStyle: .alert)
        let action = UIAlertAction(title: "OK", style: .cancel)
        alert.addAction(action)
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
