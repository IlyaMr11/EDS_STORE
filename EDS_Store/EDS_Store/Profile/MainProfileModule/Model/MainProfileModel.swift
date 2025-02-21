//
//  ProfileData.swift
//  EDS_Store
//
//  Created by Илья Морозов on 01.01.2025.
//

import Foundation

enum ProfileError: Error {
    case noInternet
    case serverError
    case noData
}


protocol MainProfileModelProtocol {
    init (networkService: ProfileNetworkServiceProtocol)
    func loadUserData(_ login: String, completion: @escaping (UserData?, ProfileError?) -> Void)
    var userData: UserData? { get set }
}

class MainProfileModel: MainProfileModelProtocol {
    let networkService: ProfileNetworkServiceProtocol
    var name: String?
    var userData: UserData?
    
    
    required init(networkService: ProfileNetworkServiceProtocol) {
        self.networkService = networkService
    }
    
    //MARK: - LOAD USER DATA
    func loadUserData(_ login: String, completion: @escaping (UserData?, ProfileError?) -> Void) {
        let db = FireBaseLayer.shared.configureFirebase()
        db.collection("UsersData").whereField("login", isEqualTo: login).getDocuments { (snapshot, error) in
            if let error = error {
                print("Error - \(error.localizedDescription)")
                completion(nil, ProfileError.noInternet)
                return
            }
            
            print("Login: \(login)")
            
            guard let snapshot = snapshot else {
                print("Error - snapshot is nil")
                completion(nil, ProfileError.serverError)
                return
            }
            
            if snapshot.isEmpty {
                print("Error - snapshot is empty")
                completion(nil, ProfileError.serverError)
                return
            }
            
            print("Snapshot documents count: \(snapshot.documents.count)")
            
            let document = snapshot.documents[0]
            let data = document.data()
            
            let name = data["name"] as? String ?? ""
            let phone = data["phone"] as? String ?? ""
            let notify = data["notify"] as? Bool ?? false
            let p = data["purchase"] as? [[String: Any]] ?? [[:]]
            let address = data["address"] as? [String] ?? []
            
            var purchases = [(Product, Int, String)]()
            for complex in p {
                let status = complex["status"] as? String ?? ""
                let count = complex["count"] as? Int ?? 0
                let pr = complex["product"] as? [String: Any] ?? [:]
                let product = ProductDecoder.prodcutDecoder(pr)
                purchases.append((product, count, status))
            }
            
            let userData = UserData(login: login, name: name, purchase: purchases, phone: phone, address: address, notify: notify)
            PersonData.shared.setUserData(userData)
            completion(userData, nil)
        }
    }
}


