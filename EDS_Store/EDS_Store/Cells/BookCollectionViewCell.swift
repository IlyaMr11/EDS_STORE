//
//  BookCollcetionViewCell.swift
//  EDS_Store
//
//  Created by Илья Морозов on 23.11.2024.
//

import UIKit

class BookCollectionViewCell: UICollectionViewCell {
    
    static let identifier = "BookCollcetionViewCell"
    let productName = [("Электро двигатели", "Червячные мотор редукторы"),
                       ("Соосно-цилиндрические мотор-редукторы", "Каническо-цилиндрические мотор редукторы"),
                       ("Планетарные редукторы", "Вариторы, мотор вариаторы"),
                       ("Цилиндрические мотор редукторы", "Преобразователи частоты, утсройства плавного пуска")]
    
    let productImage = [("motors", "motor-reducer"), ("coaxial", "conically"),
                        ("planet", "variators"), ("cylinder", "converter")]
    
    lazy var firstLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.numberOfLines = 0
        label.font = .systemFont(ofSize: 15)
        label.textColor = .black
        return label
    }()
    
    lazy var secondLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.textAlignment = .center
        label.font = .systemFont(ofSize: 15)
        label.textColor = .black
        return label
    }()
    
    lazy var firstImageButton: UIButton = {
        let button = UIButton()
        button.imageView?.contentMode = .scaleAspectFit
        return button
    }()
    
    lazy var secondImageButton: UIButton = {
        let button = UIButton()
        button.imageView?.contentMode = .scaleAspectFit
        button.addTarget(self, action: #selector(press), for: .touchUpInside)
        return button
    }()
    
    lazy var firstCellView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.layer.cornerRadius = 15
        view.layer.borderWidth = 1.5
        view.layer.borderColor = UIColor.orange.cgColor
        setupView(firstLabel, firstImageButton, view)
        return view
    }()
    
    lazy var secondCellView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.layer.cornerRadius = 15
        view.layer.borderWidth = 1.5
        view.layer.borderColor = UIColor.orange.cgColor
        setupView(secondLabel, secondImageButton, view)
        return view
    }()
    
    
    lazy var cellStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [firstCellView, secondCellView])
        stackView.axis = .horizontal
        stackView.distribution = .fillEqually
        stackView.spacing = 10
        return stackView
    }()
    
    override  init(frame: CGRect) {
        super.init(frame: frame)
        setupStackView(cellStackView)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func updateStackView(line: Int) {
        firstLabel.text = productName[line].0
        secondLabel.text = productName[line].1
        firstImageButton.setImage(UIImage(named: productImage[line].0), for: .normal)
        secondImageButton.setImage(UIImage(named: productImage[line].1), for: .normal)
    }
    
    func setupView(_ label: UILabel, _ imageView: UIButton, _ view: UIView) {
        view.addSubview(label)
        view.addSubview(imageView)
        label.translatesAutoresizingMaskIntoConstraints = false
        imageView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: view.topAnchor),
            imageView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            imageView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            imageView.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.75)])
        NSLayoutConstraint.activate([
            label.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            label.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 3),
            label.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -3),
            label.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.25)])
    }
    
    func setupStackView(_ stackView: UIStackView) {
        contentView.addSubview(stackView)
        stackView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
            stackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            stackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            stackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
        ])
                                    
    }
    
    @objc func press() {
        print("hi")
    }
}
