//
//  PhoneViewController.swift
//  EDS_Store
//
//  Created by Илья Морозов on 28.11.2024.
//

import UIKit

class PhoneView: UIViewController, UserDataViewProtocol {
    
    
    var presenter: (any UserDataPresenterProtocol)?

    
    //MARK: - PHONE VIEW
    private lazy var phoneView: UIView = {
        let view = UIView()
        view.layer.cornerRadius = 20
        view.backgroundColor = .white
        return view
    }()
    
    //MARK: - TITLE LABEL
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.text = "Номер телефона"
        label.font = .boldSystemFont(ofSize: .init(25))
        label.textAlignment = .center
        label.textColor = .black
        return label
    }()
    
    //MARK: - PHONE TEXT VIEW
    private lazy var phoneTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Введите телефон"
        textField.keyboardType = .phonePad
        textField.font = .systemFont(ofSize: 20, weight: .medium)
        if let phone = PersonData.shared.userData?.phone {
            textField.text = phone
        }
        textField.delegate = self
        textField.textAlignment = .right
        return textField
    }()
    
    //MARK: - PHONE LABEL
    private lazy var phoneLabel: UILabel = {
        let label = UILabel()
        label.text = "Телефон:"
        label.textColor = .black
        label.font = .systemFont(ofSize: 20, weight: .medium)
        return label
    }()
    
    //MARK: - SAFE BUTTON
    private lazy var safeButton: UIButton = {
        let button = UIButton()
        button.layer.cornerRadius = 15
        button.backgroundColor = .orange
        button.setTitle("Cохранить номер", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.addTarget(self, action: #selector(safePhone), for: .touchUpInside)
        button.addTarget(ButtonAnimations.shared, action: #selector(ButtonAnimations.comeback(sender:)), for: .touchUpInside)
        button.addTarget(ButtonAnimations.shared, action: #selector(ButtonAnimations.littleAndAlpha(sender:)), for: .touchDown)
        return button
    }()
    
    //MARK: - CLOSE BUTTON
    private lazy var closeButton: UIButton = {
        let button = UIButton()
        button.imageView?.contentMode = .scaleAspectFit
        button.setImage(UIImage(named: "back"), for: .normal)
        button.addTarget(self, action: #selector(closeView), for: .touchUpInside)
        button.addTarget(ButtonAnimations.shared, action: #selector(ButtonAnimations.comeback(sender:)), for: .touchUpInside)
        button.addTarget(ButtonAnimations.shared, action: #selector(ButtonAnimations.littleAndAlpha(sender:)), for: .touchDown)
        return button
    }()
    
    //MARK: - VIEW DID LOAD
    override func viewDidLoad() {
        super.viewDidLoad()
        setupEmailView()
        setupAll()
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        view.addGestureRecognizer(tapGesture)
        loadData()
    }

    func saveData() {
        presenter?.updateUserData(attr: .phone, data: phoneTextField.text ?? "")
    }
    
    func loadData() {
        presenter?.loadUserData(attr: .phone)
    }
    
    func setupData(data: Any) {
        let text = data as? String ?? ""
        phoneTextField.text = text
    }
    
    func success() {
        let alert = SuccessAlert.successSave.alert
        present(alert, animated: true)
    }
    
    func failure(error: AlertType) {
        switch error {
        case .dataError:
            showAlert(alert: AlertType.phone.alert)
        default:
            showAlert(alert: error.alert)
        }
    }
    
    //MARK: - TARGETS
    @objc func safePhone() {
        saveData()
    }
    
    //MARK: - CLOSE VIEW PRESS
    @objc func closeView() {
        dismiss(animated: true)
    }
    
    @objc func dismissKeyboard() {
        // Скрываем клавиатуру
        phoneTextField.resignFirstResponder()
    }
    
    //MARK: - SETUP EMAIL VIEW
    func setupEmailView() {
        view.addSubview(phoneView)
        phoneView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([phoneView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
                                     phoneView.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: -25),
                                     phoneView.widthAnchor.constraint(equalToConstant: view.bounds.width * 0.9),
                                     phoneView.heightAnchor.constraint(equalToConstant: view.bounds.height * 0.5)])
    }
    
    //MARK: - SETUP ALL UI OBJ
    func setupAll() {
        setupTitleLabel(titleLabel)
        setupCloseButton(closeButton)
        setupPhoneLabel(phoneLabel)
        setupTextField(phoneTextField)
        setupSafeButton(safeButton)
    }

    func setupTitleLabel(_ label: UILabel) {
        phoneView.addSubview(label)
        label.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([label.centerXAnchor.constraint(equalTo: view.centerXAnchor),
                                     label.topAnchor.constraint(equalTo: phoneView.topAnchor, constant: 5),
                                     label.heightAnchor.constraint(equalToConstant: 30),
                                     label.widthAnchor.constraint(equalToConstant: 240)])
    }
    
    func setupCloseButton(_ button: UIButton) {
        phoneView.addSubview(button)
        button.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([button.leadingAnchor.constraint(equalTo: phoneView.leadingAnchor, constant: 5),
                                     button.topAnchor.constraint(equalTo: phoneView.topAnchor, constant: 5),
                                     button.heightAnchor.constraint(equalToConstant: 40),
                                     button.widthAnchor.constraint(equalToConstant: 40)])
    }
    
    func setupPhoneLabel(_ label: UILabel) {
        phoneView.addSubview(label)
        label.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([label.leadingAnchor.constraint(equalTo: phoneView.leadingAnchor, constant: 10),
                                     label.topAnchor.constraint(equalTo: closeButton.bottomAnchor, constant: 15),
                                     label.heightAnchor.constraint(equalToConstant: 40),
                                     label.widthAnchor.constraint(equalToConstant: 100)])
    }
    
    func setupTextField(_ textField: UITextField) {
        phoneView.addSubview(textField)
        textField.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([textField.trailingAnchor.constraint(equalTo: phoneView.trailingAnchor, constant: -20),
                                     textField.centerYAnchor.constraint(equalTo: phoneLabel.centerYAnchor),
                                     textField.heightAnchor.constraint(equalToConstant: 40),
                                     textField.leadingAnchor.constraint(equalTo: phoneLabel.trailingAnchor, constant: 30)])
    }
    
    func setupSafeButton(_ button: UIButton) {
        phoneView.addSubview(button)
        button.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([button.centerXAnchor.constraint(equalTo: phoneView.centerXAnchor),
                                     button.bottomAnchor.constraint(equalTo: phoneView.bottomAnchor, constant: -20),
                                     button.widthAnchor.constraint(equalTo: phoneView.widthAnchor, multiplier: 0.6),
                                     button.heightAnchor.constraint(equalTo: phoneView.widthAnchor, multiplier: 0.15)])
    }
    
    
}

//MARK: - EXTESNSIONS
extension PhoneView: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        textField.text = "+7"
    }
    
}


