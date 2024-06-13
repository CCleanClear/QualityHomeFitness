//
//  Product2.swift
//  QualityHomeFitness
//
//  Created by Crystal Chan on 2/5/2024.
//

import Foundation

enum ProductType2: Int, CaseIterable, Identifiable{
    case All
    case AbdominalWheel
    case IndoorPullUpBar
    case Dumbbell
    case ElasticBand
    case ExerciseBike
    case ExerciseMat
    case FitnessBoard
    case Kettlebell
    case Treadmill
    case JumpRope
    
    var id: Int {
        return rawValue
    }
    
     var description:String{
        switch self{
        case .All: return "All"
        case .AbdominalWheel: return "Abdominal Wheel"
        case .IndoorPullUpBar : return  "Indoor pull-up bar"
        case .Dumbbell : return  "Dumbbell"
        case .ElasticBand : return  "Elastic band"
        case .ExerciseBike : return  "Exercise bike"
        case .ExerciseMat : return "Exercise mat"
        case .FitnessBoard : return  "Fitness board"
        case .Kettlebell : return  "Kettlebell"
        case .Treadmill : return  "Treadmill"
        case .JumpRope : return  "Jump rope"
        }
    }
    
    
}
