//
//  AddressViewController.swift
//  EDS_Store
//
//  Created by Илья Морозов on 29.11.2024.
//

import UIKit

class AddressView: UIViewController, UserDataViewProtocol {
    
    
    var presenter: (any UserDataPresenterProtocol)?
    
    
    //MARK: - CONSTANTS
    let identifier = "addressCell"
    var addresses: [String] = []
    

    //MARK: - ADD ROW BUTTON
    private lazy var addRowButton: UIButton = {
        let button = UIButton()
        button.imageView?.contentMode = .scaleAspectFit
        button.setImage(UIImage(named: "plus"), for: .normal)
        button.addTarget(self, action: #selector(addRow), for: .touchUpInside)
        return button
    }()
    
    private lazy var editButton: UIButton = {
        let button = UIButton()
        button.imageView?.contentMode = .scaleAspectFit
        button.setImage(UIImage(named: "edit"), for: .normal)
        button.addTarget(self, action: #selector(editTable), for: .touchUpInside)
        return button
    }()
    
    //MARK: - ADDRESS VIEW
    private lazy var addressView: UIView = {
        let view = UIView()
        view.layer.cornerRadius = 20
        view.backgroundColor = .white
        return view
    }()
    
    //MARK: - TITLE LABEL
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.text = "Адреса"
        label.font = .boldSystemFont(ofSize: .init(25))
        label.textAlignment = .center
        label.textColor = .black
        return label
    }()
    
    //MARK: - SAFE BUTTON
    private lazy var safeButton: UIButton = {
        let button = UIButton()
        button.layer.cornerRadius = 15
        button.backgroundColor = .orange
        button.setTitle("Cохранить адреса", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.addTarget(self, action: #selector(safeAddress), for: .touchUpInside)
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
    
    //MARK: - ADRESS TABLE VIEW
    private lazy var addressTableView: UITableView = {
        let tableView = UITableView()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(AddressTableViewCell.self, forCellReuseIdentifier: AddressTableViewCell.identifier)
        return tableView
    }()
    
    private lazy var buttonStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [editButton, addRowButton])
        stackView.axis = .horizontal
        stackView.distribution = .fillEqually
        stackView.spacing = 10
        return stackView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupAddressView()
        setupAll()
        loadData()
        // Do any additional setup after loading the view.
    }
    
    
    func saveData() {
        var data = [String]()
        for i in 0..<addresses.count {
            if let cell = addressTableView.cellForRow(at: IndexPath(row: i, section: 0)) as? AddressTableViewCell {
                if let text = cell.adressTF.text {
                    if !text.isEmpty {
                        data.append(text)
                    }
                }
            }
            
        }
        presenter?.updateUserData(attr: .address, data: data)
    }
    
    func setupData(data: Any) {
        let data = data as? [String] ?? []
        addresses = data
        addressTableView.reloadData()
    }
    
    func success() {
        let alert = SuccessAlert.successSave.alert
        present(alert, animated: true)
    }
    
    func failure(error: AlertType) {
        
    }
    
    func loadData() {
        presenter?.loadUserData(attr: .address)
    }
    
    
    //MARK: - SETUP ADDRESS VIEW
    func setupAddressView() {
        view.addSubview(addressView)
        addressView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([addressView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
                                     addressView.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: -25),
                                     addressView.widthAnchor.constraint(equalToConstant: view.bounds.width * 0.9),
                                     addressView.heightAnchor.constraint(equalToConstant: view.bounds.height * 0.5)])
    }
    
    //MARK: - SETUP ALL UI OBJ
    func setupAll() {
        setupTitleLabel(titleLabel)
        setupCloseButton(closeButton)
        setupSafeButton(safeButton)
        setupTableView(addressTableView)
        setupButtonStackView(buttonStackView)
    }

    
    //MARK: - TARGETS
    @objc func editTable() {
        addressTableView.isEditing.toggle()
    }
    
    //MARK: - WARNING !!!
    @objc func addRow() {
        addresses.append("")
        addressTableView.reloadData()
    }
    
    @objc func safeAddress() {
        saveData()
    }
    
    @objc func closeView() {
        dismiss(animated: true)
    }
    
    func setupTitleLabel(_ label: UILabel) {
        addressView.addSubview(label)
        label.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([label.centerXAnchor.constraint(equalTo: view.centerXAnchor),
                                     label.topAnchor.constraint(equalTo: addressView.topAnchor, constant: 5),
                                     label.heightAnchor.constraint(equalToConstant: 30),
                                     label.widthAnchor.constraint(equalToConstant: 100)])
        
    }
    
    func setupCloseButton(_ button: UIButton) {
        addressView.addSubview(button)
        button.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([button.leadingAnchor.constraint(equalTo: addressView.leadingAnchor, constant: 10),
                                     button.topAnchor.constraint(equalTo: addressView.topAnchor, constant: 7),
                                     button.heightAnchor.constraint(equalToConstant: 40),
                                     button.widthAnchor.constraint(equalToConstant: 40)])
    }
    
    func setupSafeButton(_ button: UIButton) {
        addressView.addSubview(button)
        button.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([button.centerXAnchor.constraint(equalTo: addressView.centerXAnchor),
                                     button.bottomAnchor.constraint(equalTo: addressView.bottomAnchor, constant: -20),
                                     button.widthAnchor.constraint(equalTo: addressView.widthAnchor, multiplier: 0.6),
                                     button.heightAnchor.constraint(equalTo: addressView.widthAnchor, multiplier: 0.15)])
    }
    
    func setupTableView(_ tableView: UITableView) {
        addressView.addSubview(tableView)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([tableView.leadingAnchor.constraint(equalTo: addressView.leadingAnchor),
                                     tableView.trailingAnchor.constraint(equalTo: addressView.trailingAnchor),
                                     tableView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 20),
                                     tableView.bottomAnchor.constraint(equalTo: safeButton.topAnchor)])
    }
    
    func setupButtonStackView(_ stackView: UIStackView) {
        addressView.addSubview(stackView)
        stackView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([stackView.trailingAnchor.constraint(equalTo: addressView.trailingAnchor, constant: -10),
                                     stackView.topAnchor.constraint(equalTo: addressView.topAnchor, constant: 7),
                                     stackView.heightAnchor.constraint(equalToConstant: 40),
                                     stackView.widthAnchor.constraint(equalToConstant: 90)])
    }
}

//MARK: - EXTENSIONS
extension AddressView: UITextFieldDelegate, UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return addresses.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: AddressTableViewCell.identifier, for: indexPath) as? AddressTableViewCell else { return UITableViewCell() }
        if !addresses[indexPath.row].isEmpty {
            cell.setupAddress(address: addresses[indexPath.row])
        }
        cell.setupNumber(number: indexPath.row)
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 70
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            addresses.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
            tableView.reloadData()
        }
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}
