//
//  Product.swift
//  QualityHomeFitness
//
//  Created by Crystal Chan on 3/3/2024.
//

import SwiftUI

struct Product: Identifiable, Hashable {
    var id = UUID().uuidString
    var type: ProductType
    var title: String
    var subtitle: String
    var description: String = ""
    var price: String
    var productImage: String  = ""
    var Star: Int = 4
}

enum ProductType: String, CaseIterable {
    
    case AbdominalWheel = "Abdominal Wheel"
    case IndoorPullUpBar = "Indoor pull-up bar"
    case Dumbbell = "Dumbbell"
    case ElasticBand = "Elastic band"
    case ExerciseBike = "Exercise bike"
    case ExerciseMat = "Exercise mat"
    case FitnessBoard = "Fitness board"
    case Kettlebell = "Kettlebell"
    case Treadmill = "Treadmill"
    case JumpRope = "Jump rope"
}
