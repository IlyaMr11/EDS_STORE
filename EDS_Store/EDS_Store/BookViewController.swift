//
//  BookViewController.swift
//  EDS_Store
//
//  Created by Илья Морозов on 23.11.2024.
//

import UIKit


class BookViewController: UIViewController {
    
    
    //MARK: - CONSTATNS
    let color1 = UIColor(red: 0.95, green: 0.95, blue: 0.95, alpha: 1)
    
    
    //MARK: - HEAD LABEL
    private lazy var headLabel: UILabel = {
        let label = UILabel()
        label.text = "Выберети категорию товара чтобы узнать больше информации"
        label.font = .boldSystemFont(ofSize: 22)
        label.textColor = .black
        label.numberOfLines = 0
        label.textAlignment = .center
        return label
    }()
    
    //MARK: - COLLECTION VIEW
    private lazy var bookCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let collectionView = UICollectionView(frame: CGRect(x: 0, y: 200, width: 375, height: 600), collectionViewLayout: layout)
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.backgroundColor = color1
        collectionView.layer.cornerRadius = 20
        collectionView.register(BookCollectionViewCell.self, forCellWithReuseIdentifier: BookCollectionViewCell.identifier)
        return collectionView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.layer.cornerRadius = 10
        view.backgroundColor = .white
        title = "Справочник"
        setupAllViews()
        // Do any additional setup after loading the view.
    }
    
    //MARK: - SETUP VIEWS
    func setupAllViews() {
        setupHeadLabel(headLabel)
        setupBookCollectionView(bookCollectionView)
    }
    
    //MARK: - SETUP LABEL
    func setupHeadLabel(_ label: UILabel) {
        view.addSubview(label)
        label.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([label.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
                                     label.centerXAnchor.constraint(equalTo: view.centerXAnchor),
                                     label.heightAnchor.constraint(equalToConstant: 100),
                                     label.widthAnchor.constraint(equalToConstant: view.bounds.width * 0.7)])
    }
    
    //MARK: - SETUP COLLECTION VIEW
    func setupBookCollectionView(_ collectionView: UICollectionView) {
        view.addSubview(collectionView)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([collectionView.topAnchor.constraint(equalTo: headLabel.bottomAnchor, constant: 35),
                                     collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
                                     collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
                                     collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor)])
    }
}


//MARK: - EXTENSIONS
extension BookViewController: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        4
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell =  collectionView.dequeueReusableCell(withReuseIdentifier: BookCollectionViewCell.identifier, for: indexPath) as! BookCollectionViewCell
        cell.updateStackView(line: indexPath.row)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: view.bounds.width - 40, height: 250) // Укажите желаемый размер ячейки
        }
    
    
    
}
