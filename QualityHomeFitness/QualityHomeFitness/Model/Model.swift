//
//  Model.swift
//  QualityHomeFitness
//
//  Created by Crystal Chan on 1/5/2024.
//

import Foundation
import SwiftUI

struct DataModel: Decodable{
    let error: Bool
    let message: String
    let data: [ProductModel]
}


struct ProductModel: Decodable{
    var id: String
    var type: String
    var title: String
    var price: String
    var brand: String
    var short: String
    var description: String
    var asin: String
    var review: String
    var dimensions: String
    var picture1Src: String
    var picture2Src: String
    var reviews: String
}
   
    
    
   
