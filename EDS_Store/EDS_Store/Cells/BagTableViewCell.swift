//
//  BagTableViewCell.swift
//  EDS_Store
//
//  Created by Илья Морозов on 19.01.2025.
//

import UIKit

protocol BagCellDelegate: AnyObject {
    func delete(index: Int, price: Int)
    func changeValue(index: Int, value: Int, price: Int)
}


class BagTableViewCell: UITableViewCell {
    
    var position: Position?
    static let identifier = "bagCell"
    
    var index: Int = 0
    weak var delegate: BagCellDelegate?
    
    
    //MARK: - BACK VIEW
    private lazy var backView: UIView = {
        let view = UIView()
        view.backgroundColor = .systemGray5
        view.layer.cornerRadius = 8
        return view
    }()
    
    //MARK: - PRODUCT IMAGE
    lazy var productImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.layer.cornerRadius = 8
        imageView.backgroundColor = .white
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    //MARK: - STEPPER
    private lazy var stepper: UIStepper = {
        let stepper = UIStepper()
        stepper.value = 1
        stepper.minimumValue = 1
        stepper.maximumValue = 15
        stepper.stepValue = 1
        stepper.layer.cornerRadius = 5
        stepper.backgroundColor = .orange
        let plusImage = UIImage(systemName: "plus")?.withTintColor(.white, renderingMode: .alwaysOriginal)
        let minusImage = UIImage(systemName: "minus")?.withTintColor(.white, renderingMode: .alwaysOriginal)
        stepper.setIncrementImage(plusImage, for: .normal)
        stepper.setDecrementImage(minusImage, for: .normal)
        stepper.addTarget(self, action: #selector(changeVal(_:)), for: .valueChanged)
        return stepper
    }()
    
    //MARK: DELETE BUTTON
    private lazy var deleteButton: UIButton = {
        let button = UIButton()
        button.layer.cornerRadius = 5
        button.backgroundColor = .orange
        button.setImage(UIImage(systemName: "trash"), for: .normal)
        button.tintColor = .white
        button.addTarget(self, action: #selector(deleteItem), for: .touchUpInside)
        return button
    }()
    
    //MARK: - COUNT LABEL
    private lazy var countLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.font = .systemFont(ofSize: 17, weight: .medium)
        label.text = String(Int(stepper.value))
        return label
    }()
    
    //MARK: - DESCRIPTION LABEL
    private lazy var descriptionLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.font = .systemFont(ofSize: 22, weight: .heavy)
        return label
    }()
    
    //MARK: - PRICE LABEL
    private lazy var priceLabel : UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 20, weight: .medium)
        return label
    }()
    
    //MARK: - TOTAL LABEL
    private lazy var totalLabel : UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 20, weight: .medium)
        label.textAlignment = .right
        return label
    }()

    //MARK: - STACK VIEWS
    lazy var stepperStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [self.stepper, self.countLabel])
        stackView.axis = .horizontal
        stackView.distribution = .fill
        stackView.spacing = 10
        return stackView
    }()
    
    lazy var descriptionStackView: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [self.descriptionLabel, self.priceLabel])
        stack.axis = .vertical
        stack.spacing = 20
        return stack
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier identifier: String?) {
        super.init(style: style, reuseIdentifier: identifier)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - COFIGURE CELL
    func configure(with position: Position) {
        self.position = position
        guard let pr = self.position?.product else { return }
        priceLabel.text = "Цена: \(pr.price) ₽"
        descriptionLabel.text = pr.name
        totalLabel.text = "Итог:    \(String(position.count * (Int(pr.price) ?? 0)))₽"
        countLabel.text = String(position.count)
        stepper.value = Double(position.count)
        print(countLabel.text ?? "no text")
    }
    
    func loadPhoto(image: UIImage) {
        productImageView.image = image
    }
    
    //MARK: - SETUP UI
    func setupUI() {
        setupBackView(backView)
        setupImageView(productImageView)
        setupDescriptionStack(descriptionStackView)
        setupSteper(stepperStackView)
        setupDeleteButton(deleteButton)
        setupTotalLabel(totalLabel)
    }

    //MARK: - TARGETS
    @objc func deleteItem() {
        print("delete item")
        delegate?.delete(index: self.index, price: Int(position?.product.price ?? "0") ?? 0)
    }
    
    @objc func changeVal(_ sender: UIStepper) {
        countLabel.text = String(Int(sender.value))
        totalLabel.text = "Итог:    \(String(Int(sender.value) * (Int(position?.product.price ?? "0") ?? 0)))₽"
        delegate?.changeValue(index: index, value: Int(sender.value), price: Int(position?.product.price ?? "0") ?? 0)
    }
    
    //MARK: - SETUP AND CONSTRAINTS
    func setupBackView(_ backView: UIView) {
        contentView.addSubview(backView)
        backView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            backView.topAnchor.constraint(equalTo: contentView.topAnchor),
            backView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -10),
            backView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10),
            backView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10)
        ])
    }

    func setupImageView(_ imageView: UIImageView) {
        backView.addSubview(imageView)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: backView.topAnchor, constant: 5),
            imageView.leadingAnchor.constraint(equalTo: backView.leadingAnchor, constant: 5),
            imageView.widthAnchor.constraint(equalToConstant: 160),
            imageView.heightAnchor.constraint(equalToConstant: 230)
        ])
    }

    func setupSteper(_ stepper: UIStackView) {
        backView.addSubview(stepper)
        stepper.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            stepper.topAnchor.constraint(equalTo: productImageView.bottomAnchor, constant: 10),
            stepper.heightAnchor.constraint(equalToConstant: 30),
            stepper.leadingAnchor.constraint(equalTo: productImageView.leadingAnchor),
            stepper.widthAnchor.constraint(equalTo: productImageView.widthAnchor, multiplier: 0.85)])
    }
    
    func setupDescriptionStack(_ stackView: UIStackView) {
        backView.addSubview(stackView)
        stackView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: productImageView.topAnchor, constant: 7),
            stackView.trailingAnchor.constraint(equalTo: backView.trailingAnchor, constant: -10),
            stackView.leadingAnchor.constraint(equalTo: productImageView.trailingAnchor, constant: 10), // Исправлено
            stackView.heightAnchor.constraint(equalToConstant: 200)
        ])
    }

    func setupDeleteButton(_ button: UIButton) {
        backView.addSubview(button)
        button.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            button.centerYAnchor.constraint(equalTo: stepperStackView.centerYAnchor),
            button.trailingAnchor.constraint(equalTo: backView.trailingAnchor, constant: -10),
            button.heightAnchor.constraint(equalToConstant: 30),
            button.widthAnchor.constraint(equalToConstant: 25)
        ])
    }

    func setupTotalLabel(_ label: UILabel) {
        backView.addSubview(label)
        label.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            label.centerYAnchor.constraint(equalTo: stepperStackView.centerYAnchor),
            label.trailingAnchor.constraint(equalTo: deleteButton.leadingAnchor, constant: -15),
            label.heightAnchor.constraint(equalTo: stepperStackView.heightAnchor),
            label.leadingAnchor.constraint(equalTo: stepperStackView.trailingAnchor) // Исправлено
        ])
    }
}


