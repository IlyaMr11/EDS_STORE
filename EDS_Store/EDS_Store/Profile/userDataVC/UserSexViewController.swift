//
//  UserSexViewController.swift
//  EDS_Store
//
//  Created by Илья Морозов on 27.11.2024.
//

import UIKit

class UserSexViewController: UIViewController {

    //MARK: - DELEGATE AND CONSTS
    weak var delegate: UpdateUserDataDelegate?
    let viewRadius = CGFloat(20)
    
    //MARK: - SEX VEIW
    private lazy var sexView: UIView = {
        let sexView = UIView()
        sexView.backgroundColor = .white
        sexView.layer.cornerRadius = viewRadius
        return sexView
    }()
    
    //MARK: - TITLE LABEL
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.text = "Пол"
        label.font = .boldSystemFont(ofSize: .init(25))
        label.textAlignment = .center
        label.textColor = .black
        return label
    }()
    
    //MARK: - SEGMENTS
    private lazy var sexSegmentedControl: UISegmentedControl = {
        let segment = UISegmentedControl(items: ["Мужской", "Женский"])
        segment.layer.cornerRadius = 15
        let normalAttributes: [NSAttributedString.Key: Any] = [.foregroundColor: UIColor.orange]
        let selectedAttributes: [NSAttributedString.Key: Any] = [.foregroundColor: UIColor.white]
        segment.setTitleTextAttributes(normalAttributes, for: .normal)
        segment.setTitleTextAttributes(selectedAttributes, for: .selected)
        segment.tintColor = .white
        segment.selectedSegmentTintColor = .black
        if let sex = user1Data.sex {
            segment.selectedSegmentIndex = sex == "Мужской" ? 0 : 1
        }
        return segment
    }()
    
    //MARK: - SAFE BUTTON
    private lazy var safeButton: UIButton = {
        let button = UIButton()
        button.layer.cornerRadius = 15
        button.backgroundColor = .orange
        button.setTitle("Cохранить пол", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.addTarget(self, action: #selector(safeSex), for: .touchUpInside)
        return button
    }()
    
    //MARK: - CLSOE BUTTON
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
        setupSexView()
        setupAll()
    }
    
    //MARK: - SETUP SEX VIEW
    func setupSexView() {
        view.addSubview(sexView)
        sexView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([sexView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
                                     sexView.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: -25),
                                     sexView.widthAnchor.constraint(equalToConstant: view.bounds.width * 0.9),
                                     sexView.heightAnchor.constraint(equalToConstant: view.bounds.height * 0.5)])
    }
      
    //MARK: - SETUP ALL UI OBJ
    func setupAll() {
        setupTitleLabel(titleLabel)
        setupCloseButton(closeButton)
        setupSegment(sexSegmentedControl)
        setupSafeButton(safeButton)
    }
    
    func setupTitleLabel(_ label: UILabel) {
        sexView.addSubview(label)
        label.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([label.centerXAnchor.constraint(equalTo: view.centerXAnchor),
                                     label.topAnchor.constraint(equalTo: sexView.topAnchor, constant: 5),
                                     label.heightAnchor.constraint(equalToConstant: 30),
                                     label.widthAnchor.constraint(equalToConstant: 100)])
    }
    
    func setupCloseButton(_ button: UIButton) {
        sexView.addSubview(button)
        button.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([button.leadingAnchor.constraint(equalTo: sexView.leadingAnchor, constant: 5),
                                     button.topAnchor.constraint(equalTo: sexView.topAnchor, constant: 5),
                                     button.heightAnchor.constraint(equalToConstant: 40),
                                     button.widthAnchor.constraint(equalToConstant: 40)])
    }
    
    func setupSegment(_ segment: UISegmentedControl) {
        sexView.addSubview(segment)
        segment.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([segment.centerXAnchor.constraint(equalTo: sexView.centerXAnchor),
                                     segment.topAnchor.constraint(equalTo: closeButton.bottomAnchor, constant: 25),
                                     segment.heightAnchor.constraint(equalToConstant: 70),
                                     segment.widthAnchor.constraint(equalToConstant: 250)])
    }
    
    func setupSafeButton(_ button: UIButton) {
        sexView.addSubview(button)
        button.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([button.centerXAnchor.constraint(equalTo: sexView.centerXAnchor),
                                     button.bottomAnchor.constraint(equalTo: sexView.bottomAnchor, constant: -20),
                                     button.widthAnchor.constraint(equalTo: sexView.widthAnchor, multiplier: 0.6),
                                     button.heightAnchor.constraint(equalTo: sexView.widthAnchor, multiplier: 0.15)])
    }
    
    //MARK: - TARGETS
    @objc func closeView() {
        dismiss(animated: true)
    }
    
    //MARK: - SAFE SEX PRESS
    @objc func safeSex() {
        switch sexSegmentedControl.selectedSegmentIndex {
        case 0:
            user1Data.sex = "Мужской"
        case 1:
            user1Data.sex = "Женский"
        default:
            print("no data")
        }
        dismiss(animated: true)
    }

}
