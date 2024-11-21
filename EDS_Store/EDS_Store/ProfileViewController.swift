//
//  ProfileViewController.swift
//  EDS_Store
//
//  Created by Илья Морозов on 18.11.2024.
//
import UIKit


class ProfileViewController: UIViewController {
    
    let color1 = UIColor.init(red: 0.95, green: 0.95, blue: 0.95, alpha: 1)
    let cellsText = ["Ваши доставки", "Истрия заказов", "Настройки",
                     "Тех поддержка", "Способы оплаты", "Возврат тоавра", "Смторели недавно"]
    
    private lazy var nameLabel: UILabel = {
        let label = UILabel()
        label.layer.cornerRadius = 15
        label.text = "Илья Морозов"
        label.numberOfLines = 0
        label.font = .boldSystemFont(ofSize: 25)
        label.textColor = .black
        label.backgroundColor = color1
        return label
    }()
    
    private lazy var userInfoButton: UIButton = {
        let button = UIButton()
        let image = UIImage(named: "user")
        button.tintColor = .black
        button.setImage(image, for: .normal)
        button.backgroundColor = color1
        button.layer.cornerRadius = 15
        return button
    }()
    
    private lazy var grayView: UIView = {
        let view = UIView()
        view.backgroundColor = color1
        view.layer.cornerRadius = 15
        view.layer.borderWidth = 1.5
        view.layer.borderColor = UIColor.orange.cgColor
        return view
    }()
    
    private lazy var profileTableView: UITableView = {
        let tableView = UITableView()
        tableView.backgroundColor = color1
        tableView.separatorStyle = .singleLine
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        tableView.dataSource = self
        tableView.delegate = self
        tableView.layer.cornerRadius = 15
        return tableView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupAllViews()
        view.backgroundColor = .white
        title = "Профиль"
        
    }
    
    func setupAllViews() {
        setupGrayView(grayView)
        setupUserInfoButton(userInfoButton)
        setupNameLabel(nameLabel)
        setupProfileTableView(profileTableView)
    }
    
    func setupGrayView(_ View: UIView) {
        view.addSubview(grayView)
        View.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            View.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 10), View.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor), View.heightAnchor.constraint(equalToConstant: 75), View.widthAnchor.constraint(equalToConstant: view.bounds.width * 0.85)])
    }
    
    func setupUserInfoButton(_ button: UIButton) {
        view.addSubview(button)
        button.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            button.centerYAnchor.constraint(equalTo: grayView.centerYAnchor), button.trailingAnchor.constraint(equalTo: grayView.trailingAnchor, constant: -5), button.heightAnchor.constraint(equalToConstant: 70), button.widthAnchor.constraint(equalToConstant: 70)])
    }
    
    func setupNameLabel(_ label: UILabel) {
        view.addSubview(label)
        label.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([label.centerYAnchor.constraint(equalTo: userInfoButton.centerYAnchor), label.leadingAnchor.constraint(equalTo: grayView.leadingAnchor, constant: 15), label.trailingAnchor.constraint(equalTo: userInfoButton.leadingAnchor, constant: -30), label.heightAnchor.constraint(equalToConstant: 60)])
    }
    
    func setupProfileTableView(_ tableView: UITableView) {
        view.addSubview(tableView)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([tableView.topAnchor.constraint(equalTo: grayView.bottomAnchor, constant: 35),
                                     tableView.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor), tableView.widthAnchor.constraint(equalToConstant: view.bounds.width), tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)])
    }
}

extension ProfileViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cellsText.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = cellsText[indexPath.row]
        cell.accessoryType = .disclosureIndicator
        cell.backgroundColor = color1
        cell.layer.cornerRadius = 10
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 70
    }
    
    
}
