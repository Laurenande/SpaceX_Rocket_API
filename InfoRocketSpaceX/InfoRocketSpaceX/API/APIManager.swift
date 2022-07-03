//
//  APIManager.swift
//  InfoRocketSpaceX
//
//  Created by Егор Куракин on 17.04.2022.
//

import Foundation
import Alamofire
enum ApiType {
    case getRocket
    
    var request: URLRequest {
        let url = URL(string: "https://api.spacexdata.com/v4/rockets/")!
        let request = URLRequest(url: url)
        return request
    }
}

// MARK: - ApiManager
//info Rocket
class ApiManager{
    static let shared = ApiManager()
    var isHeightM = true
    var isDiameterM = true
    var isWeightKg = true
    var isLoadKg = true
    func getInfo(completion: @escaping (Rocket) -> Void){
        let request = ApiType.getRocket.request
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            if let data = data, let rocket = try? JSONDecoder().decode(Rocket.self, from: data) {
                completion(rocket)
            }else{
                completion([])
            }
        }
        task.resume()
    }
}

