//
//  UserNameViewController.swift
//  EDS_Store
//
//  Created by Илья Морозов on 27.11.2024.
//

import UIKit

class NameView: UIViewController, UserDataViewProtocol {
    
    var presenter: (any UserDataPresenterProtocol)?
    

    //MARK: - DELEGATE AND CONSTANTS
    weak var delegate: UpdateUserDataDelegate?
    let viewRadius = CGFloat(20)
//    let showStyle = 
    
    //MARK: - NAME VIEW
    private lazy var nameView: UIView = {
        let view = UIView()
        view.layer.cornerRadius = viewRadius
        view.backgroundColor = .white
        return view
    }()
    
    //MARK: - TITLE LABEL
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.text = "Имя"
        label.font = .boldSystemFont(ofSize: .init(25))
        label.textAlignment = .center
        label.textColor = .black
        return label
    }()
    
    //MARK: - TEXT FIELD
    private lazy var nameTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Ваше имя"
        textField.text = user1Data.name
        textField.delegate = self
        textField.textAlignment = .right
        return textField
    }()
    
    //MARK: - NAME LABEL
    private lazy var nameLabel: UILabel = {
        let label = UILabel()
        label.text = "Имя:"
        label.textColor = .black
        label.font = .systemFont(ofSize: 19)
        return label
    }()
    
    //MARK: - SAFE BUTTON
    private lazy var safeButton: UIButton = {
        let button = UIButton()
        button.layer.cornerRadius = 15
        button.backgroundColor = .orange
        button.setTitle("Cохранить имя", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.addTarget(self, action: #selector(safeName), for: .touchUpInside)
        return button
    }()
    
    //MARK: - CLOSE BUTTON
    private lazy var closeButton: UIButton = {
        let button = UIButton()
        button.imageView?.contentMode = .scaleAspectFit
        button.setImage(UIImage(named: "back"), for: .normal)
        button.addTarget(self, action: #selector(closeView), for: .touchUpInside)
        return button
    }()
    
    //MARK: - VIEW DID LOAD
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNameView()
        setupAll()
        // Do any additional setup after loading the view.
    }
    
    func saveData() {
        
    }
    
    func loadData() {
        
    }
    
    func success() {
        
    }
    
    func failure(error: UserDataError) {
        
    }
    
    
    //MARK: - TARGETS
    @objc func safeName() {
        if Checker.shared.checkUserName(nameTextField.text) {
            if let name = nameTextField.text {
                user1Data.name = name
                delegate?.didUpdateName(name)
                dismiss(animated: true)
            }
        } else {
            showAlert(alert: allAlerts.userNameAlert)
        }
    }
    
    func showAlert(alert: UIAlertController) {
        present(alert, animated: true)
    }
    
    //MARK: - CLOSE VIEW PRESS
    @objc func closeView() {
        dismiss(animated: true)
    }
    
    //MARK: - SETUP NAME VIEW
    func setupNameView() {
        view.addSubview(nameView)
        nameView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([nameView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
                                     nameView.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: -25),
                                     nameView.widthAnchor.constraint(equalToConstant: view.bounds.width * 0.9),
                                     nameView.heightAnchor.constraint(equalToConstant: view.bounds.height * 0.5)])
    }
    
    //MARK: - SETUP ALL UI OBJ
    func setupAll() {
        setupTitleLabel(titleLabel)
        setupCloseButton(closeButton)
        setupNameLabel(nameLabel)
        setupTextField(nameTextField)
        setupSafeButton(safeButton)
    }

    func setupTitleLabel(_ label: UILabel) {
        nameView.addSubview(label)
        label.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([label.centerXAnchor.constraint(equalTo: view.centerXAnchor),
                                     label.topAnchor.constraint(equalTo: nameView.topAnchor, constant: 5),
                                     label.heightAnchor.constraint(equalToConstant: 30),
                                     label.widthAnchor.constraint(equalToConstant: 100)])
    }
    
    func setupCloseButton(_ button: UIButton) {
        nameView.addSubview(button)
        button.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([button.leadingAnchor.constraint(equalTo: nameView.leadingAnchor, constant: 5),
                                     button.topAnchor.constraint(equalTo: nameView.topAnchor, constant: 5),
                                     button.heightAnchor.constraint(equalToConstant: 40),
                                     button.widthAnchor.constraint(equalToConstant: 40)])
    }
    
    func setupNameLabel(_ label: UILabel) {
        nameView.addSubview(label)
        label.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([label.leadingAnchor.constraint(equalTo: nameView.leadingAnchor, constant: 10),
                                     label.topAnchor.constraint(equalTo: closeButton.bottomAnchor, constant: 15),
                                     label.heightAnchor.constraint(equalToConstant: 40),
                                     label.widthAnchor.constraint(equalToConstant: 50)])
    }
    
    func setupTextField(_ textField: UITextField) {
        nameView.addSubview(textField)
        textField.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([textField.trailingAnchor.constraint(equalTo: nameView.trailingAnchor, constant: -10),
                                     textField.centerYAnchor.constraint(equalTo: nameLabel.centerYAnchor),
                                     textField.heightAnchor.constraint(equalToConstant: 40),
                                     textField.leadingAnchor.constraint(equalTo: nameLabel.trailingAnchor, constant: 30)])
                                    
    }
    
    func setupSafeButton(_ button: UIButton) {
        nameView.addSubview(button)
        button.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([button.centerXAnchor.constraint(equalTo: nameView.centerXAnchor),
                                     button.bottomAnchor.constraint(equalTo: nameView.bottomAnchor, constant: -20),
                                     button.widthAnchor.constraint(equalTo: nameView.widthAnchor, multiplier: 0.6),
                                     button.heightAnchor.constraint(equalTo: nameView.widthAnchor, multiplier: 0.15)])
    }
    
}

//MARK: - EXTENSION
extension NameView: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}
