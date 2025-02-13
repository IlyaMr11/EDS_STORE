//
//  NotificatioinViewController.swift
//  EDS_Store
//
//  Created by Илья Морозов on 28.11.2024.
//

import UIKit

class NotificationView: UIViewController, UserDataViewProtocol {
    
    
    var presenter: (any UserDataPresenterProtocol)?
    
    
    //MARK: - NOTIFICATION VIEW
    private lazy var notificationView: UIView = {
        let sexView = UIView()
        sexView.backgroundColor = .white
        sexView.layer.cornerRadius = 20
        return sexView
    }()
    
    //MARK: - TITLE LABEL
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.text = "Уведомления"
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
        button.setTitle("Cохранить настройки", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.addTarget(self, action: #selector(safeNotification), for: .touchUpInside)
        return button
    }()
    
    //MARK: - NOTIFC SWITCH
    private lazy var notifcSwitch: UISwitch = {
        let switcher = UISwitch()
        switcher.onTintColor = .orange
        if let isOn =  PersonData.shared.userData?.notify {
            switcher.isOn = isOn
        }
        return switcher
    }()
    
    //MARK: - NOTIFICATION LABEL
    private lazy var notificationLabel: UILabel = {
        let label = UILabel()
        label.text = "Получать уведомления:"
        label.textColor = .black
        label.font = .boldSystemFont(ofSize: .init(15))
        return label
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
        setupNotificView()
        setupAll()
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
    @objc func closeView() {
        dismiss(animated: true)
    }

    //MARK: - SAFE NOTIFICATION PRESS
    @objc func safeNotification() {
        //user1Data.notify = notifcSwitch.isOn
        dismiss(animated: true , completion: nil)
    }
    
    //MARK: - SETUP NOTIFIC VIEW
    func setupNotificView() {
        view.addSubview(notificationView)
        notificationView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([notificationView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
                                    notificationView.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: -25),
                                    notificationView.widthAnchor.constraint(equalToConstant: view.bounds.width * 0.9),
                                    notificationView.heightAnchor.constraint(equalToConstant: view.bounds.height * 0.5)])
    }
    
    //MARK: - SETUP ALL UI OBJ
    func setupAll() {
        setupTitleLabel(titleLabel)
        setupCloseButton(closeButton)
        setupNotificationLabel(notificationLabel)
        setupSwitch(notifcSwitch)
        setupSafeButton(safeButton)
    }

    func setupTitleLabel(_ label: UILabel) {
        notificationView.addSubview(label)
        label.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([label.centerXAnchor.constraint(equalTo: view.centerXAnchor),
                                     label.topAnchor.constraint(equalTo: notificationView.topAnchor, constant: 5),
                                     label.heightAnchor.constraint(equalToConstant: 30),
                                     label.widthAnchor.constraint(equalToConstant: 200)])
        
    }
    
    func setupCloseButton(_ button: UIButton) {
        notificationView.addSubview(button)
        button.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([button.leadingAnchor.constraint(equalTo: notificationView.leadingAnchor, constant: 5),
                                     button.topAnchor.constraint(equalTo: notificationView.topAnchor, constant: 5),
                                     button.heightAnchor.constraint(equalToConstant: 40),
                                     button.widthAnchor.constraint(equalToConstant: 40)])
    }
    
    func setupNotificationLabel(_ label: UILabel) {
        notificationView.addSubview(label)
        label.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([label.leadingAnchor.constraint(equalTo: notificationView.leadingAnchor, constant: 10),
                                     label.topAnchor.constraint(equalTo: closeButton.bottomAnchor, constant: 15),
                                     label.heightAnchor.constraint(equalToConstant: 40),
                                     label.widthAnchor.constraint(equalToConstant: 200)])
    }
    
    func setupSwitch(_ switcher: UISwitch) {
        notificationView.addSubview(switcher)
        switcher.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([switcher.trailingAnchor.constraint(equalTo: notificationView.trailingAnchor, constant: -10),
                                     switcher.centerYAnchor.constraint(equalTo: notificationLabel.centerYAnchor),
                                     switcher.heightAnchor.constraint(equalToConstant: 40)])
    }
    
    func setupSafeButton(_ button: UIButton) {
        notificationView.addSubview(button)
        button.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([button.centerXAnchor.constraint(equalTo: notificationView.centerXAnchor),
                                     button.bottomAnchor.constraint(equalTo: notificationView.bottomAnchor, constant: -20),
                                     button.widthAnchor.constraint(equalTo: notificationView.widthAnchor, multiplier: 0.6),
                                     button.heightAnchor.constraint(equalTo: notificationView.widthAnchor, multiplier: 0.15)])
    }
    
}
