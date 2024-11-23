//
//  BookViewController.swift
//  EDS_Store
//
//  Created by Илья Морозов on 23.11.2024.
//

import UIKit


class BookViewController: UIViewController {
    
   
    
    let productName = ["Электро двигатели", "Червячные мотор-редукторы",
                       "Соосно-цилиндрические мотор-редукторы", "Каническо-цилиндрические мотор-редукторы",
                       "Планетарные редукторы", "Вариторы, мотор-вариаторы",
                       "Цилиндрические мотор-редукторы", "Преобразователи частоты, утсройства плавного пуска"]
    let productImage = ["AT90", "AT90", "AT90", "AT90", "AT90", "AT90", "AT90", "AT90"]
        
    private lazy var headLabel: UILabel = {
        let label = UILabel()
        label.text = "Выберети категорию товара чтобы узнать больше информации"
        label.font = .boldSystemFont(ofSize: 22)
        label.textColor = .black
        label.numberOfLines = 0
        label.textAlignment = .center
        return label
    }()
    
    private lazy var bookCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let collectionView = UICollectionView(frame: CGRect(x: 0, y: 200, width: 375, height: 600), collectionViewLayout: layout)
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(BookCollectionViewCell.self, forCellWithReuseIdentifier: BookCollectionViewCell.identifier)
        return collectionView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupAllViews()
        // Do any additional setup after loading the view.
    }
    
    func setupAllViews() {
        setupHeadLabel(headLabel)
        setupBookCollectionView(bookCollectionView)
    }
    
    func setupHeadLabel(_ label: UILabel) {
        view.addSubview(label)
        label.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([label.topAnchor.constraint(equalTo: view.topAnchor, constant: 20),
                                     label.centerXAnchor.constraint(equalTo: view.centerXAnchor),
                                     label.heightAnchor.constraint(equalToConstant: 100),
                                     label.widthAnchor.constraint(equalToConstant: view.bounds.width * 0.7)])
    }
    
    func setupBookCollectionView(_ collectionView: UICollectionView) {
        view.addSubview(collectionView)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([collectionView.topAnchor.constraint(equalTo: headLabel.bottomAnchor, constant: 35),
                                     collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
                                     collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
                                     collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor)])
    }
}

extension BookViewController: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        4
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell =  collectionView.dequeueReusableCell(withReuseIdentifier: BookCollectionViewCell.identifier, for: indexPath) as! BookCollectionViewCell
        cell.firstLabel.text = productName[indexPath.row]
        cell.secondLabel.text = productName[indexPath.row]
        cell.firstImageView.image = UIImage(named: productImage[indexPath.row])
        cell.secondImageView.image = UIImage(named: productImage[indexPath.row])
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
            return CGSize(width: 100, height: 150) // Укажите желаемый размер ячейки
        }
    
    
    
}
