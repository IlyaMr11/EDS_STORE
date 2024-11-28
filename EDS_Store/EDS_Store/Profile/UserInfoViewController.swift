//
//  UserInfoViewController.swift
//  EDS_Store
//
//  Created by Илья Морозов on 27.11.2024.
//

import UIKit

class UserInfoViewController: UIViewController {

    let color1 = UIColor(red: 0.95, green: 0.95, blue: 0.95, alpha: 0.95)
    let color2 = UIColor(red: 0.90, green: 0.90, blue: 0.90, alpha: 0.90)
    let userCellData = ["Имя", "Пол", "Номер телефона", "Почта", "Адреса", "Уведомления"]
    let identifier = "userCell"
    
    private lazy var userPhotoImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.layer.cornerRadius = 80
        imageView.backgroundColor = color2
        imageView.image = UIImage(named: "userPhoto")
        return imageView
    }()
    
    var userNameLabel: UILabel = {
        let label = UILabel()
        if let userName = user1Data.name {
            label.text = userName
        } else {
            label.text = "Имя не указано"
        }
        label.font = .systemFont(ofSize: 18)
        return label
    }()
    
    private lazy var userTableView: UITableView = {
        let tableView = UITableView()
        tableView.separatorColor = .black
        tableView.separatorStyle = .singleLine
        tableView.layer.cornerRadius = 20
        tableView.backgroundColor = color1
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: identifier)
        return tableView
    }()
    
    private lazy var logoView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.image = UIImage(named: "logo7")
        return imageView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Мои данные"
        setupAll()
        // Do any additional setup after loading the view.
    }
    
    
    func setupAll() {
        setupUserPhoto(userPhotoImageView)
        setupUserName(userNameLabel)
        setupLogo(logoView)
        setupTableView(userTableView)
    }
    
    func setupUserPhoto(_ imageView: UIImageView) {
        view.addSubview(imageView)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 35),
            imageView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant:  20),
            imageView.heightAnchor.constraint(equalToConstant: 160),
            imageView.widthAnchor.constraint(equalToConstant: 160)])
    }
    
    func setupUserName(_ label: UILabel) {
        view.addSubview(label)
        label.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            label.centerYAnchor.constraint(equalTo: userPhotoImageView.centerYAnchor),
            label.leadingAnchor.constraint(equalTo: userPhotoImageView.trailingAnchor, constant: 20),
            label.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -50),
            label.heightAnchor.constraint(equalToConstant: 40)])
    
    }
    
    func setupLogo(_ imageView: UIImageView) {
        view.addSubview(imageView)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            imageView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -5),
            imageView.heightAnchor.constraint(equalToConstant: 120),
            imageView.widthAnchor.constraint(equalToConstant: 170),
            imageView.centerXAnchor.constraint(equalTo: view.centerXAnchor)])
    }

    func setupTableView(_ tableView: UITableView) {
        view.addSubview(tableView)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: userPhotoImageView.bottomAnchor, constant: 30),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: logoView.topAnchor, constant: -5)])
    }

}

extension UserInfoViewController: UITableViewDataSource, UITableViewDelegate, UpdateUserDataDelegate {
    func didUpdateSex(_ data: String?) {
        //
    }
    
    func didUpdateName(_ data: String?) {
        if let name = data {
            userNameLabel.text = name
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        6
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: identifier, for: indexPath)
        cell.textLabel?.text = userCellData[indexPath.row]
        cell.accessoryType = .disclosureIndicator
        cell.backgroundColor = color1
        cell.layer.cornerRadius = 10
        cell.textLabel?.numberOfLines = 2
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 70
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let row = indexPath.row
        switch row {
            case 0:
            let vc = UserNameViewController()
            vc.delegate = self
            vc.modalPresentationStyle = .pageSheet
            present(vc, animated: true)
        case 1:
            let vc = UserSexViewController()
            vc.delegate = self
            vc.modalPresentationStyle = .pageSheet
            present(vc, animated: true)
        case 2:
            let vc = PhoneViewController()
            vc.modalPresentationStyle = .pageSheet
            present(vc, animated: true, completion: nil)
        case 3:
            let vc = EmailViewController()
            vc.modalPresentationStyle = .pageSheet
            present(vc, animated: true , completion: nil)
        case 5:
            let vc = NotificationViewController()
            vc.modalPresentationStyle = .pageSheet
            present(vc, animated: true , completion: nil)
        default:
            print("trouble")
        } // Показываем второй контроллер
        
        
        
    }
    
}
