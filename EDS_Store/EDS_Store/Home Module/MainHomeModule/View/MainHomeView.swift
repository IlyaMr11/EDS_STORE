//
//  CatalogViewController.swift
//  EDS_Store
//
//  Created by Илья Морозов on 19.11.2024.
//

import UIKit

protocol MainHomeViewProtocol: AnyObject {
    func success()
    func failure()
    func configureTable(productArray: [(Product, Product)])
}

class MainHomeView: UIViewController, MainHomeViewProtocol {
    
    var presenter: MainHomePresenterProtocol?
    var productArray: [(Product, Product)] = []
    //MARK: - VIEWS
    
    private lazy var searchView: UIView = {
        let view = UIView()
        view.backgroundColor = .systemGray4
        view.layer.cornerRadius = 20
        view.layer.borderWidth = 1
        //view.layer.borderColor = UIColor.orange.cgColor
        return view
    }()
    
    private lazy var searchTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Поиск..."
        textField.font = .systemFont(ofSize: 20)
        textField.backgroundColor = .systemGray4
        textField.delegate = self
        textField.textAlignment = .left
        return textField
    }()
    
    
    private lazy var findButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "search")?.withTintColor(.orange), for: .normal)
        button.addTarget(self, action: #selector(searchProduct), for: .touchUpInside)
        button.imageView?.contentMode = .scaleAspectFit
        return button
    }()
    
    private lazy var mainTableView: UITableView = {
        let tableView = UITableView()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.layer.cornerRadius = 20
        tableView.separatorStyle = .none
        tableView.backgroundColor = .systemGray4
        tableView.register(MainHomeTableViewCell.self, forCellReuseIdentifier: MainHomeTableViewCell.identifier)
        return tableView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Главная"
        view.backgroundColor = .white
        success()
    }
    

    
    func success() {
        setupAllViews()
        loadData()
    }
    
    func configureTable(productArray: [(Product, Product)]) {
        self.productArray = productArray
        mainTableView.reloadData()
    }
    
    func loadData() {
        presenter?.showProductData()
    }
    
    func setupAllViews() {
        setupSearchView(searchView)
        setupTableView(mainTableView)
    }
    
    func setupTextField(_ textField: UITextField) {
        searchView.addSubview(textField)
        textField.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([textField.topAnchor.constraint(equalTo: searchView.topAnchor, constant: 15), textField.leftAnchor.constraint(equalTo: searchView.leftAnchor, constant: 20),
        textField.rightAnchor.constraint(equalTo: searchView.rightAnchor, constant: -100), textField.bottomAnchor.constraint(equalTo: searchView.bottomAnchor, constant: -20)])
    }
    
    func setupSearchButton(_ button: UIButton) {
        searchView.addSubview(button)
        button.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([button.centerYAnchor.constraint(equalTo: searchView.centerYAnchor), button.rightAnchor.constraint(equalTo: searchView.rightAnchor, constant: -25),
                                     button.widthAnchor.constraint(equalToConstant: 30), button.heightAnchor.constraint(equalToConstant: 30)])
    }
    
    func setupSearchView(_ sView: UIView) {
        view.addSubview(sView)
        sView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([sView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20), sView.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor, constant: 20),
            sView.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor, constant: -20),
            sView.heightAnchor.constraint(equalToConstant: 80)])
        setupTextField(searchTextField)
        setupSearchButton(findButton)
    }
    
    func setupTableView(_ table: UITableView) {
        view.addSubview(table)
        table.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([table.topAnchor.constraint(equalTo: searchView.bottomAnchor, constant: 20), table.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor), table.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor), table.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -10)])
    }
    
    func failure() {
        
    }
    
    @objc func searchProduct() {
        
    }
}

extension MainHomeView: UITextFieldDelegate & UITableViewDelegate & UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        productArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: MainHomeTableViewCell.identifier, for: indexPath) as! MainHomeTableViewCell
        let productTup = productArray[indexPath.row]
        cell.configure(with: productTup)
        presenter?.setupPicture(productTup, cell: cell)
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        300
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}
