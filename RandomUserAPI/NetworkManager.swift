//
//  NetworkManager.swift
//  RandomUserAPI
//
//  Created by Егоров Михаил on 26.02.2023.
//

import Alamofire

class NetworkManager {
    static let shared = NetworkManager()
    
    private let urlParams = [
        "results":"\(15)",
    ]
    
    let URL = "https://randomuser.me/api/"
    
    private init() {}
    
    func fetchUsers(_ completion: @escaping ([User]) -> Void) {
        AF.request(URL, parameters: urlParams)
            .validate()
            .responseJSON { dataResponse in
                switch dataResponse.result {
                case .success(let value):
                    guard let results = User.getRandomUsers(from: value) else { return }
                    completion(results)
                case .failure(let error):
                    print(error)
                }
            }
    }
    
    func fetchData(from url: String, completion: @escaping (Data) -> Void) {
        AF.request(url)
            .validate()
            .responseData { response in
                switch response.result  {
                case .success(let data):
                    completion(data)
                case .failure(let error):
                    print(error)
                }
            }
    }
    
}
