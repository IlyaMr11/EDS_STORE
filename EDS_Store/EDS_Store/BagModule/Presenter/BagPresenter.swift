//
//  BagPresenter.swift
//  EDS_Store
//
//  Created by Илья Морозов on 19.01.2025.
//

import UIKit

protocol BagPresenterProtocol {
    init(view: BagViewProtocol, router: BagRouterProtocol, model: BagModelProtocol)
    func addCountProductv(newVal: Int, index: Int)
    func setupData()
    func setupImages(array: [(Product, Int)])
}

class BagPresenter: BagPresenterProtocol {
    
    let model: BagModelProtocol!
    var view: BagViewProtocol?
    var router: BagRouterProtocol?
    
    required init(view: any BagViewProtocol, router: any BagRouterProtocol, model: any BagModelProtocol) {
        self.view = view
        self.model = model
        self.router = router
    }
    
    
    func addCountProductv(newVal: Int, index: Int) {
        
    }
    
    
    func setupData() {
        model?.loadData() { [weak self] (data, alert) in
            if let alert = alert {
                DispatchQueue.main.async {
                    self?.view?.failure(alert: alert)
                }
                return
            }
            
            if let data = data {
                DispatchQueue.main.async {
                    self?.view?.success(array: data)
                }
            }
                
        }
//        guard !UserBasket.shared.currentBasket.isEmpty else {
//            let alert = AlertType.emptyBasket.alert
//            view?.failure(alert: alert)
//            return }
//        print("i push data")
//        let array = UserBasket.shared.currentBasket
//        view?.success(array: array)
//        
//        DispatchQueue.global().async {
//            var imagesArray: [UIImage] = []
//            for pr in array {
//                let group = DispatchGroup()
//                group.enter()
//                let urlString = pr.0.picture
//                self.model.loadPhoto(urlString: urlString) { image in
//                    guard let image = image else {
//                        print("Proble")
//                        return }
//                    imagesArray.append(image)
//                    group.leave()
//                }
//                group.wait()
//                
//            }
//            
//            DispatchQueue.main.async {
//                self.view?.loadImages(imageArray: imagesArray)
//            }
//        }

    }
    
    func setupImages(array: [(Product, Int)]) {
        DispatchQueue.global().async { [weak self] in
            let group = DispatchGroup()
            var photos: [UIImage] = []
            for (p, c) in array {
                group.enter()
                let url = p.picture
                self?.model.loadPhoto(urlString: url) { [weak self] (image, alert) in
                    if let alert = alert {
                        DispatchQueue.main.async {
                            self?.view?.failure(alert: alert)
                        }
                        group.leave()
                        return
                    }
                    if let image = image {
                        photos.append(image)
                    }
                    group.leave()
                }
            }
            group.wait()
            DispatchQueue.main.async {
                self?.view?.loadImages(imageArray: photos)
            }
        }
    }
    
}
