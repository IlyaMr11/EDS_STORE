//
//  BagPresenter.swift
//  EDS_Store
//
//  Created by Илья Морозов on 19.01.2025.
//

import UIKit

protocol BagPresenterProtocol {
    init(view: BagViewProtocol, router: BagRouterProtocol, model: BagModelProtocol)
    func addCountProductv(newVal: Int, product: Product, user: UserBag)
    func pushBasketToView()
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
    
    func addCountProductv(newVal: Int, product: any Product, user: UserBag) {
        
    }
    
    func pushBasketToView() {
        guard !UserBasket.shared.currentBasket.isEmpty else {
            let alert = AlertType.emptyBasket.alertController
            view?.failure(alert: alert)
            return }
        print("i push data")
        let array = UserBasket.shared.currentBasket
        view?.success(array: array)
        
        DispatchQueue.global().async {
            var imagesArray: [UIImage] = []
            for pr in array {
                let group = DispatchGroup()
                group.enter()
                let urlString = pr.0.picture
                self.model.loadPhoto(urlString: urlString) { image in
                    guard let image = image else {
                        print("Proble")
                        return }
                    imagesArray.append(image)
                    group.leave()
                }
                group.wait()
                
            }
            
            DispatchQueue.main.async {
                self.view?.loadImages(imageArray: imagesArray)
            }
        }

    }
    
}
