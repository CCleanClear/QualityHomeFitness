//
//  ImageClassification.swift
//  QualityHomeFitness
//
//  Created by Crystal Chan on 14/5/2024.
//

import Foundation
import UIKit
import ImageIO
import CoreML
import Vision

class ImageClassification: ObservableObject {
    @Published var classificationLabel: String = "Add a photo."
    
    //Image Model
    lazy var classificationRequest: VNCoreMLRequest = {
        do {
            let modelURL = Bundle.main.url(forResource: "Fitness_model", withExtension: "mlmodelc")!
            let model = try VNCoreMLModel(for: Fitness_model(contentsOf: modelURL).model)
            
            let request = VNCoreMLRequest(model: model, completionHandler: { [weak self] request, error in
                self?.processClassifications(for: request, error: error)
            } )
            
            request.imageCropAndScaleOption = .centerCrop
            return request
        } catch {
            fatalError("Failed to load Vision ML model: \(error)")
        }
    }()
    
    func updateClassifications(for image: UIImage) {
        classificationLabel = "Classifying..."
        
        let orientation = CGImagePropertyOrientation(image.imageOrientation)
        guard let ciImage = CIImage(image: image) else { fatalError("Unable to create \(CIImage.self) from \(image).") }
        
        DispatchQueue.global(qos: .userInitiated).async {
            let handler = VNImageRequestHandler(ciImage: ciImage, orientation: orientation)
            do {
                try handler.perform([self.classificationRequest])
            } catch {
                print("Failed to perform classification.\n\(error.localizedDescription)")
            }
        }
    }
    
    //update result
    func processClassifications(for request: VNRequest, error: Error?) {
        DispatchQueue.main.async {
            guard let results = request.results else {
                self.classificationLabel = "Unable to classify image.\n\(error!.localizedDescription)"
                return
            }
            let classifications = results as! [VNClassificationObservation]
        
            if classifications.isEmpty {
                self.classificationLabel = "Nothing recognized."
            } else {
                let topClassifications = classifications.prefix(1)
                let descriptions = topClassifications.map { classification in
                   // let percentage = Int(classification.confidence * 100)
                     //return String(format: "(%d%%) %@", percentage, classification.identifier)
                    return String(classification.identifier)
                }
                self.classificationLabel = "Result Classification:\n" + descriptions.joined(separator: "\n")
            }
        }
    }
}


