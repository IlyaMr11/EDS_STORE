//
//  RegistrationViewController.swift
//  EDS_Store
//
//  Created by Илья Морозов on 16.11.2024.
//
import UIKit

struct Fields {
    let password: String
    let login: String
    let name: String
    let confirmPassword: String
}

protocol RegistrationViewProtocol: AnyObject {
    func success()
    func failure(alert: UIAlertController)
}

class RegistrationView: UIViewController, RegistrationViewProtocol {
    
    //MARK: - CONSTANTS
    let buttonsRadius: CGFloat = 13
    
    let alertsArray = [allAlerts.userNameAlert, allAlerts.emailAlert, allAlerts.passwordAlert, allAlerts.confirmPasswordAlert]
    
    var presenter: RegistrationPresenterProtocol?
    
    //MARK: WELCOME LABEL
    private lazy var welcomLabel:  UILabel = {
        let label = UILabel()
        label.text = "Зарегистрируйтесь чтобы офрмить заказ"
        label.textColor = .white
        label.font = .boldSystemFont(ofSize: 25)
        label.textAlignment = .center
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    //MARK: LOGO
    private lazy var logoImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "logo7")
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    //MARK: - REG BUTTON
    private lazy var registrationButton: UIButton = {
        let button = UIButton()
        button.setTitle("Зарегистрироваться", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = .black
        button.layer.cornerRadius = buttonsRadius
        button.layer.borderWidth = 1.5
        button.addTarget(self, action: #selector(registration), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    //MARK: - TEXTS FEIELDS
    private lazy var userNameTextField: UITextField = {
        let textField = UITextField()
        textField.delegate = self
        textField.layer.cornerRadius = buttonsRadius
        textField.borderStyle = .none
        textField.placeholder = "Введите Имя"
        textField.layer.borderWidth = 1.5
        textField.backgroundColor = .white
        return textField
    }()
    
    private lazy var emailTextField: UITextField = {
        let textField = UITextField()
        textField.delegate = self
        textField.keyboardType = .emailAddress
        textField.layer.cornerRadius = buttonsRadius
        textField.borderStyle = .none
        textField.placeholder = "Введите Почту"
        textField.layer.borderWidth = 1.5
        textField.backgroundColor = .white
        return textField
    }()
    
    //MARK: - PASSWORD
    private lazy var passwordTextField: UITextField = {
        let textField = UITextField()
        textField.delegate = self
        textField.layer.cornerRadius = buttonsRadius
        textField.borderStyle = .none
        textField.placeholder = "Введите Пароль"
        textField.layer.borderWidth = 1.5
        textField.layer.borderColor = UIColor.black.cgColor
        textField.backgroundColor = .white
        return textField
    }()
    
    private lazy var confinrmPasswordTextField: UITextField = {
        let textField = UITextField()
        textField.delegate = self
        textField.layer.cornerRadius = buttonsRadius
        textField.borderStyle = .none
        textField.layer.borderColor = UIColor.black.cgColor
        textField.placeholder = "Подтвердите Пароль"
        textField.layer.borderWidth = 1.5
        textField.backgroundColor = .white
        return textField
    }()
    
    //MARK: - STACKVIEW
    private lazy var stackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [userNameTextField, emailTextField, passwordTextField, confinrmPasswordTextField])
        stackView.axis = .vertical
        stackView.spacing = 25
        stackView.distribution = .fillEqually
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .orange
        title = "Регистрация"
        setupAll()
    }
    
    func success() {
        let alert = UIAlertController(title: "Регистрация успешна", message: "Вы успешно зарегистрировались", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Ок", style: .cancel))
        
        let action = UIAlertAction(title: "На экран регистрации", style: .default) { [weak self] _ in
            self?.presenter?.toSignIn()
        }

        alert.addAction(action)
        present(alert, animated: true)
        presenter?.toSignIn()
    }
    
    func failure(alert: UIAlertController) {
        present(alert, animated: true)
    }
    
    //MARK: - SETUP
    func setupAll(){
        setupLabel(welcomLabel)
        setupStackView(stackView)
        setupRegButton(registrationButton)
        setupLogo()
    }
    
    //MARK: - TARGETS
    @objc func registration() {
        let password = passwordTextField.text ?? ""
        let name = userNameTextField.text ?? ""
        let login = emailTextField.text ?? ""
        let confinrmPassword = confinrmPasswordTextField.text ?? ""
        presenter?.registerUser(Fields(password: password, login: login, name: name, confirmPassword: confinrmPassword))
    }
    
    //MARK: - SETUP LABEL
    func setupLabel(_ label: UILabel) {
        view.addSubview(label)
        label.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 15).isActive = true
        label.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        label.widthAnchor.constraint(equalToConstant: view.bounds.width * 0.8).isActive = true
        label.heightAnchor.constraint(equalToConstant: view.bounds.height * 0.08).isActive = true
    }
    
    //MARK: - SETUP STACKVIEW
    func setupStackView(_ stackView: UIStackView) {
        view.addSubview(stackView)
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: welcomLabel.bottomAnchor, constant: 20),
            stackView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            stackView.widthAnchor.constraint(equalToConstant: view.bounds.width * 0.7),
            stackView.heightAnchor.constraint(equalToConstant: view.bounds.height * 0.35)])
    }
    
    func setupRegButton(_ button: UIButton) {
        view.addSubview(button)
        button.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -15).isActive = true
        button.heightAnchor.constraint(equalToConstant: view.bounds.height * 0.07).isActive = true
        button.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        button.widthAnchor.constraint(equalToConstant: view.bounds.width * 0.7).isActive = true
    }
    
    //MARK: - SETUP LOGO
    func setupLogo() {
        view.addSubview(logoImageView)
        NSLayoutConstraint.activate([
            logoImageView.bottomAnchor.constraint(equalTo: registrationButton.topAnchor, constant: -35),
            logoImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: view.bounds.width * 0.025),
            logoImageView.widthAnchor.constraint(equalToConstant: view.bounds.width * 0.45),
            logoImageView.heightAnchor.constraint(equalToConstant: view.bounds.height * 0.14)])
    }
}

//MARK: - EXTENSION
extension RegistrationView: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
}

