//
//  FireProduct.swift
//  QualityHomeFitness
//
//  Created by jackychoi on 26/4/2024.
//

import SwiftUI
import FirebaseFirestoreSwift

//MARK: post model
struct FireProduct: Identifiable,Codable{
    @DocumentID var id: String?
    var asin: String
    var brand: String
    var dimensions: String
    var price: Int
    var review: String
    var short: String
    var single: String
    var title: String
    var type: String
    
    enum CodingKeys: CodingKey{
        case id
        case asin
        case brand
        case dimensions
        case price
        case review
        case short
        case single
        case title
        case type
    }
}
