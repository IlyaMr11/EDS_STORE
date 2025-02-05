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
    var rowCounter = 0
    

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
    
    //MARK: - ADRESS TABLE VIEW
    private lazy var addressTableView: UITableView = {
        let tableView = UITableView()
        rowCounter = user1Data.address.count
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: identifier)
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

    
    
    
    //MARK: - CREATE TABLE CELL
    func createTableCell(_ index: Int) -> UIView {
        print("hi")
        let view = UIView(frame: CGRect(x: 0, y: 0, width: self.view.bounds.width, height: 70))
        let label = UILabel(frame: CGRect(x: 5, y: 0, width: 90, height: 70))
        label.text = "Адрес №\(index+1)"
        label.textColor = .black
        view.addSubview(label)
        let textField = UITextField(frame: CGRect(x: 145, y: 0, width: view.bounds.width - 250, height: 70))
        textField.placeholder = "Введите адрес"
        textField.textAlignment = .left
        textField.delegate = self
        textField.tag = index
        if user1Data.address.count > index {
            textField.text = user1Data.address[index]
        }
        view.addSubview(textField)
        return view
    }
    
    //MARK: - TARGETS
    @objc func editTable() {
        addressTableView.isEditing.toggle()
    }
    
    @objc func addRow() {
        rowCounter += 1
        user1Data.address.append("")
        print(rowCounter)
        addressTableView.reloadData()
    }
    
    @objc func safeName() {
        dismiss(animated: true)
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
        return rowCounter
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: identifier, for: indexPath)
        cell.contentView.addSubview(createTableCell(indexPath.row))
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 70
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, moveRowAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
        user1Data.address.swapAt(sourceIndexPath.row, destinationIndexPath.row)
        tableView.reloadData()
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            user1Data.address.remove(at: indexPath.row)
            rowCounter -= 1
            tableView.deleteRows(at: [indexPath], with: .fade)
            tableView.reloadData()
        }
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        if let text = textField.text {
            if textField.tag >= user1Data.address.count {
                user1Data.address.append(text)
            } else {
                user1Data.address[textField.tag] = text
            }
        }
        return true
    }
}
