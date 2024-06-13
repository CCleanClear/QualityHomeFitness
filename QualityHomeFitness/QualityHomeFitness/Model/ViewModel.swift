//
//  ViewModel.swift
//  QualityHomeFitness
//
//  Created by Crystal Chan on 1/5/2024.
//

import Foundation
import SwiftUI

//class ViewModel: ObservableObject {
//    @Published var itmes = [ProductModel]()
//    let prefixUrl = "http://localhost:80"
//    
//    init() {
//       fetchProducts()
//    }
//    
//    func fetchProducts() {
//        guard let url = URL(string: "\(prefixUrl)/api.php") else{
//            print("Not found url")
//            return
//        }
//        
//        URLSession.shared.dataTask(with: url) { data, res, error in
//            if error != nil {
//                print("error", error?.localizedDescription ?? "")
//                return
//            }
//            
//            do {
//                if let data = data {
//                    let decoder = JSONDecoder()
//                    let result = try decoder.decode(DataModel.self, from: data)
//                    DispatchQueue.main.async {
//                        self.itmes = result.data
//                    }
//                } else {
//                    print("no data")
//                }
//                
//            } catch let JsonError {
//                print("fetch json error", JsonError.localizedDescription ?? "")
//            }
//            
//            
//        }.resume()
//    }
//}


