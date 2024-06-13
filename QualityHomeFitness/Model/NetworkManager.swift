//
//  NetworkManger.swift
//  QualityHomeFitness
//
//  Created by Crystal Chan on 1/5/2024.
//

import Foundation

struct NetworkManager {
    static func fetchData(completion: @escaping ([ResponseModel]) -> Void) {
        guard let url = URL(string: "http://localhost:80/api.php") else {
            print("Invalid URL")
            return
        }
        
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = "GET"
        
        URLSession.shared.dataTask(with: urlRequest) { (data, response, error) in
            guard let data = data else {
                print("Invalid response")
                return
            }
            
            do {
                let models = try JSONDecoder().decode([ResponseModel].self, from: data)
                completion(models)
            } catch {
                print(error.localizedDescription)
            }
        }.resume()
    }
}
