//
//  ProfileViewController.swift
//  EDS_Store
//
//  Created by Илья Морозов on 18.11.2024.
//
import UIKit


protocol MainProfileViewProtocol: AnyObject {
    func success()
    func updateName()
    func failure(alert: UIAlertController?)
    func setupName(_ name: String)
}

class MainProfileView: UIViewController, MainProfileViewProtocol {
    
    //MARK: - CONSTANTS
    
    let color1 = UIColor.init(red: 0.95, green: 0.95, blue: 0.95, alpha: 1)
    let buttonRadius = CGFloat(15)
    let cellsText = ["Ваши доставки", "История заказов",
                     "Способы оплаты", "Имя", "Номер телефона", "Адреса", "Уведомления"]
    
    var presenter: MainProfilePresenterProtocol?

    
    //MARK: - LOGO
    private lazy var logoImageView: UIImageView = {
        let imageView = UIImageView(image: UIImage(named: "logo7"))
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    //MARK: - WARNING BUTTON
    private lazy var warningLabel: UILabel = {
        let label = UILabel()
        label.text = "Войдите или заргистрируйтесь, чтобы пользоваться всеми функциями EDStore"
        label.textColor = .gray
        label.textAlignment = .center
        label.numberOfLines = 0
        return label
    }()
    
    //MARK: - TO SIGN BUTTON
    private lazy var toSignButton: UIButton = {
        let button = UIButton()
        button.setTitle("Войти или зарегистрироваться", for: .normal)
        button.backgroundColor = .orange
        button.layer.cornerRadius = buttonRadius
        button.addTarget(self, action: #selector(toSignVC(sender:)), for: .touchUpInside)
        return button
    }()
    
    //MARK: - AFTER SIGN VIEW
    private lazy var nameLabel: UILabel = {
        let label = UILabel()
        label.layer.cornerRadius = buttonRadius
        label.numberOfLines = 0
        label.font = .boldSystemFont(ofSize: 25)
        label.textColor = .black
        label.backgroundColor = color1
        return label
    }()
    
    //MARK: - USER INFO BUTTON
    private lazy var userInfoButton: UIButton = {
        let button = UIButton()
        let image = UIImage(named: "user")
        button.tintColor = .black
        button.setImage(image, for: .normal)
        button.backgroundColor = color1
        button.layer.cornerRadius = buttonRadius
        //button.addTarget(self, action: #selector(userInfoVC), for: .touchUpInside)
        return button
    }()
    
    //MARK: - GRAY BAGROUND
    private lazy var grayView: UIView = {
        let view = UIView()
        view.backgroundColor = color1
        view.layer.cornerRadius = buttonRadius
        view.layer.borderWidth = 1.5
        view.layer.borderColor = UIColor.orange.cgColor
        return view
    }()
    
    //MARK: - PROFILE TableView
    private lazy var profileTableView: UITableView = {
        let tableView = UITableView()
        tableView.backgroundColor = color1
        tableView.separatorStyle = .singleLine
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        tableView.dataSource = self
        tableView.delegate = self
        tableView.layer.cornerRadius = buttonRadius
        return tableView
    }()
    
    //MARK: - VIEW DID LOAD
    override func viewDidLoad() {
        super.viewDidLoad()
        print("I load ")
        setupViews()
        view.backgroundColor = .white
        title = "Профиль"
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        updateName()
    }
    
    //MARK: - CHOOSE VIEW
    func setupViews() {
        if PersonData.shared.currentUser != nil {
            success()
            print("ura")
        } else {
            print("faile i call")
            failure()
        }
             
    }
    
    //MARK: - TARGETS
    @objc func toSignVC(sender: UIButton) {
        ButtonAnimations.growSize(layer: sender.layer)
        presenter?.toSignIn()
    }
    
    //MARK: - SHOULD REMOVE
    @objc func userInfoVC() {
        presenter?.tapOnUserInfo()
    }
    
    //MARK: - SETUP BEFORE SIGN
    func failure(alert: UIAlertController? = nil) {
        setupLogo(logoImageView)
        setupWarningLabel(warningLabel)
        setupToSignButton(toSignButton)
    }
    
    //MARK: - SETUP AFTER SIGN
    func success() {
        setupGrayView(grayView)
        setupUserInfoButton(userInfoButton)
        setupNameLabel(nameLabel)
        setupProfileTableView(profileTableView)
        loadName()
    }
    
    
    func setupName(_ name: String) {
        print("I setup name")
        nameLabel.text = name
    }
    
    func updateName() {
        print("i Update name")
        if let name = PersonData.shared.userData?.name {
            nameLabel.text = name
        }
    }
    
    func loadName() {
        presenter?.loadName(PersonData.shared.currentUser?.login ?? "")
    }
    
    //MARK: - SETUP LOGO
    func setupLogo(_ imageView: UIImageView) {
        view.addSubview(imageView)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([imageView.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor), imageView.centerYAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerYAnchor, constant: -view.bounds.height * 0.1), imageView.widthAnchor.constraint(equalToConstant: view.bounds.width * 0.4), imageView.heightAnchor.constraint(equalToConstant: view.bounds.height * 0.12)])
    }
    
    //MARK: - SETUP WARNING LABEL
    func setupWarningLabel(_ label: UILabel) {
        view.addSubview(label)
        label.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([label.centerXAnchor.constraint(equalTo: view.centerXAnchor), label.topAnchor.constraint(equalTo: logoImageView.bottomAnchor, constant: 15), label.heightAnchor.constraint(equalToConstant: 60), label.widthAnchor.constraint(equalToConstant: view.bounds.width * 0.85)])
    }
    
    //MARK: - SETUP TO SIGNVC BUTTON
    func setupToSignButton(_ button: UIButton) {
        view.addSubview(button)
        button.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([button.centerXAnchor.constraint(equalTo: view.centerXAnchor), button.topAnchor.constraint(equalTo: warningLabel.bottomAnchor, constant: 15), button.heightAnchor.constraint(equalToConstant: 60), button.widthAnchor.constraint(equalToConstant: view.bounds.width * 0.7)])
    }
    
    //MARK: - SETUP GRAY VIEW
    func setupGrayView(_ View: UIView) {
        view.addSubview(grayView)
        View.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            View.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20), View.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor), View.heightAnchor.constraint(equalToConstant: 75), View.widthAnchor.constraint(equalToConstant: view.bounds.width * 0.85)])
    }
    
    //MARK: - SETUP USERINFO
    func setupUserInfoButton(_ button: UIButton) {
        view.addSubview(button)
        button.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            button.centerYAnchor.constraint(equalTo: grayView.centerYAnchor), button.trailingAnchor.constraint(equalTo: grayView.trailingAnchor, constant: -5), button.heightAnchor.constraint(equalToConstant: 70), button.widthAnchor.constraint(equalToConstant: 70)])
    }
    
    //MARK: - SETUP NAME LABEL
    func setupNameLabel(_ label: UILabel) {
        view.addSubview(label)
        label.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([label.centerYAnchor.constraint(equalTo: userInfoButton.centerYAnchor), label.leadingAnchor.constraint(equalTo: grayView.leadingAnchor, constant: 15), label.trailingAnchor.constraint(equalTo: userInfoButton.leadingAnchor, constant: -30), label.heightAnchor.constraint(equalToConstant: 60)])
    }
    
    //MARK: - SETUP PROFILE TableView
    func setupProfileTableView(_ tableView: UITableView) {
        view.addSubview(tableView)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([tableView.topAnchor.constraint(equalTo: grayView.bottomAnchor, constant: 45),
                                     tableView.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor), tableView.widthAnchor.constraint(equalToConstant: view.bounds.width), tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -20)])
    }

}


//MARK: - EXTENSION
extension MainProfileView: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cellsText.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = cellsText[indexPath.row]
        cell.textLabel?.font = UIFont.systemFont(ofSize: 20, weight: .semibold)
        cell.accessoryType = .disclosureIndicator
        cell.backgroundColor = color1
        cell.layer.cornerRadius = 10
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        presenter?.tapOnCell(index: indexPath.row)
    }
    
}



