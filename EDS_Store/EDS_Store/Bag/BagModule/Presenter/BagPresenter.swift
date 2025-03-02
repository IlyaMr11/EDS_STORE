//
//  BagPresenter.swift
//  EDS_Store
//
//  Created by Илья Морозов on 19.01.2025.
//

import UIKit

protocol BagPresenterProtocol {
    init(view: BagViewProtocol, router: BagRouterProtocol, model: BagModelProtocol)
    func setupData()
    func setupImages(array: [Position])
    func toConfirmModule()
}

class BagPresenter: BagPresenterProtocol {
    
    //MARK: - PROPERTIES
    
    let model: BagModelProtocol!
    var view: BagViewProtocol?
    var router: BagRouterProtocol?
    
    required init(view: any BagViewProtocol, router: any BagRouterProtocol, model: any BagModelProtocol) {
        self.view = view
        self.model = model
        self.router = router
    }

    //MARK: - PROTOCOL METHODS
    
    func toConfirmModule() {
        router?.confirmModule()
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
    }
    
    func setupImages(array: [Position]) {
        DispatchQueue.global().async { [weak self] in
            let group = DispatchGroup()
            var photos: [UIImage] = []
            
            for p in array {
                group.enter()
                let url = p.product.picture
                
                NetworkLayer.loadPhoto(path: url) { (image, alert) in
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
