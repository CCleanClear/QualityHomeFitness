//
//  HomeViewModel.swift
//  QualityHomeFitness
//
//  Created by Crystal Chan on 3/3/2024.
//

import SwiftUI
import Combine

class HomeViewModel: ObservableObject {
    @Published var productType: ProductType = .AbdominalWheel
    
    @Published var products: [Product] = [
        Product(type: .AbdominalWheel, title: "Flat abdominal wheel", subtitle: "ONETWOFIT-ET017601", price: "$98", productImage: "A_1"),
        Product(type: .AbdominalWheel, title: "Double roller-abdominal wheel", subtitle: "Ruibao", price: "$108", productImage: "A_2"),
        Product(type: .AbdominalWheel, title: "Foldable abdominal muscle back roller fitness equipment", subtitle: "Create excellence", price: "$268", productImage: "A_3"),
        Product(type: .AbdominalWheel, title: "Abdominal muscle wheel", subtitle: "Innix", price: "$88", productImage: "A_4"),
        Product(type: .AbdominalWheel, title: "Zudis multifunctional abdominal wheel", subtitle: "Mescal", price: "$104", productImage: "A_5"),
        
        Product(type: .IndoorPullUpBar, title: "Adjustable door single lever", subtitle: "Mescal", price: "$298", productImage: "I_1"),
        Product(type: .IndoorPullUpBar, title: "Install single pole on door without nailing", subtitle: "digishare", price: "$189", productImage: "I_2"),
        Product(type: .IndoorPullUpBar, title: "Pull-up bar", subtitle: "ONETWOFIT-OT076", price: "$628", productImage: "I_3"),
        Product(type: .IndoorPullUpBar, title: "Door-mounted pull-up training rack", subtitle: "VH0244", price: "$188", productImage: "I_4"),
        Product(type: .IndoorPullUpBar, title: "Quick installation without drilling single pole on the door", subtitle: "ONETWOFIT-OT051601", price: "$288", productImage: "I_5"),
        
        Product(type: .Dumbbell, title: "3-in-1 dumbbell barbell kettlebell set", subtitle: "Oji Port - (10KG) FEIERDUN", price: "$349", productImage: "D_1"),
        Product(type: .Dumbbell, title: "Plum Dumbbell 3KG-2PCS", subtitle: "Oji Port - (10KG) FEIERDUN", price: "$349", productImage: "D_2"),
        Product(type: .Dumbbell, title: "2-in-1 Dumbbell and Barbell Set-Silver", subtitle: "Yoshida family", price: "$468", productImage: "D_3"),
        Product(type: .Dumbbell, title: "Multifunctional three-in-one dumbbell", subtitle: "ONETWOFIT - OT057001 [2-24KG]", price: "$1388", productImage: "D_4"),
        Product(type: .Dumbbell, title: "Household [Multi-Function] Fitness Dumbbells", subtitle: "Found-40KG", price: "$999", productImage: "D_5"),
        
        Product(type: .ElasticBand, title: "Elastic band", subtitle: "ONETWOFIT - OT071 [15-piece set]", price: "$198", productImage: "E_1"),
        Product(type: .ElasticBand, title: "Fitness elastic band resistance band", subtitle: "Bestseller in Japan - [5-piece set]", price: "$108", productImage: "E_2"),
        Product(type: .ElasticBand, title: "Figure 8 tensioner", subtitle: "Best Seller in Japan - 15 lbs.", price: "$49", productImage: "E_4"),
        Product(type: .ElasticBand, title: "Yoga elastic band", subtitle: "Fat boy opens a position", price: "$15", productImage: "E_3"),
        Product(type: .ElasticBand, title: "Figure 8 yoga resistance belt", subtitle: "KzHOUSE", price: "$78", productImage: "E_5"),
        
        Product(type: .ExerciseBike, title: "Exercise bike 2.5KG magnetic wheel", subtitle: "ONETWOFIT - OT047701 Xbike", price: "$2388", productImage: "EB_1"),
        Product(type: .ExerciseBike, title: "Magnetic exercise bike", subtitle: "Kettler - ECOBIKE XS", price: "$3188", productImage: "EB_2"),
        Product(type: .ExerciseBike, title: "Basic version-Magnetic resistance", subtitle: "things gather together", price: "$2679", productImage: "EB_3"),
        Product(type: .ExerciseBike, title: "Mini exercise bike", subtitle: "Yoshidaya - Mini Exercise Bike", price: "$289", productImage: "EB_4"),
        Product(type: .ExerciseBike, title: "Mini exercise bike", subtitle: "ITSU Mitsurumono", price: "$699", productImage: "EB_5"),
        
        Product(type: .ExerciseMat, title: "Yoga mat 10mm", subtitle: "Ruibao", price: "$118", productImage: "EM_1"),
        Product(type: .ExerciseMat, title: "Fitness non-slip yoga exercise mat", subtitle: "NIKE", price: "$199", productImage: "EM_2"),
        Product(type: .ExerciseMat, title: "1CM thick yoga mat", subtitle: "Camellia Life Museum", price: "$73.9", productImage: "EM_3"),
        Product(type: .ExerciseMat, title: "YNBR environmentally friendly material solid color yoga mat", subtitle: "(Purple)", price: "$108", productImage: "EM_4"),
        Product(type: .ExerciseMat, title: "Thickened 15mm sports yoga mat", subtitle: "Japan Dolphin Department Store", price: "$159", productImage: "EM_5"),
        
        Product(type: .FitnessBoard, title: "Foldable multifunctional push-up fitness board exercise equipmentt", subtitle: "(With soft rubber handshake)", price: "$55", productImage: "F_1"),
        Product(type: .FitnessBoard, title: "Fitness Flat Bench Flying Bird Fitness Board", subtitle: "Found it", price: "$799", productImage: "F_2"),
        Product(type: .FitnessBoard, title: "Professional foldable dumbbell bench", subtitle: "Found it", price: "$1199", productImage: "F_3"),
        Product(type: .FitnessBoard, title: "Professional dumbbell bench multifunctional home fitness board", subtitle: "Found it", price: "$1199", productImage: "F_4"),
        Product(type: .FitnessBoard, title: "Multi-angle adjustable weight bench and dumbbell bench", subtitle: "Found it", price: "$1999", productImage: "F_5"),
        
        Product(type: .Kettlebell, title: "10kg kettlebell", subtitle: "Kettler ", price: "$466", productImage: "K_1"),
        Product(type: .Kettlebell, title: "Household [Multi-Function] Fitness Dumb Kettlebell", subtitle: "Found - 25KG", price: "$699", productImage: "K_2"),
        Product(type: .Kettlebell, title: "Home fitness kettlebell", subtitle: "Found it ", price: "$248", productImage: "K_3"),
        Product(type: .Kettlebell, title: "Adjustable 40 pound kettlebell for home use", subtitle: "Found it ", price: "$888", productImage: "K_4"),
        Product(type: .Kettlebell, title: "12kg kettlebell", subtitle: "Kettler ", price: "$556.2", productImage: "K_5"),
        
        Product(type: .Treadmill, title: "Mini hiking walker", subtitle: "ONETWOFIT-OT0341-01 ", price: "$2888", productImage: "T_1"),
        Product(type: .Treadmill, title: "Fully folding automatic maintenance treadmill", subtitle: "ONETWOFIT-OT158UK", price: "$3088", productImage: "T_2"),
        Product(type: .Treadmill, title: "2-in-1 foldable treadmill", subtitle: "ONETWOFIT-OT0348-03", price: "$2688", productImage: "T_3"),
        Product(type: .Treadmill, title: "Foldable Treadmill 2-in-1 R2", subtitle: "Xiaomi Youpin - Goldsmiths", price: "$4399", productImage: "T_4"),
        Product(type: .Treadmill, title: "Home folding treadmill [with Bluetooth speaker]", subtitle: "ONETWOFIT-OT0332-02", price: "$2888", productImage: "T_5"),
        
        Product(type: .JumpRope, title: "BLUE JUMP ROPE ELECTRONIC LAP COUNTER", subtitle: "Hot selling in Korea", price: "$96", productImage: "J_1"),
        Product(type: .JumpRope, title: "Wireless weighted ball jump rope", subtitle: "Ruibao Selection - (Pink Big Ball Style)", price: "$98", productImage: "J_2"),
        Product(type: .JumpRope, title: "High quality silicone portable speed skipping rope", subtitle: "Face Young Outlet", price: "$88", productImage: "J_3"),
        Product(type: .JumpRope, title: "Cordless fitness skipping rope", subtitle: "Hot selling in Japan", price: "$67", productImage: "J_4"),
        Product(type: .JumpRope, title: "Calorie intelligent calculation skipping rope", subtitle: "Hot selling in Korea", price: "$79", productImage: "J_5")
        
        
    ]
    
    @Published var filteredProducts: [Product] = []
    
    @Published var showMoreProductOnType: Bool = false
    
    @Published var searchText: String = ""
    @Published var searchActivated: Bool = false
    @Published var searchedProducts: [Product]?
    
    var searchCancellable: AnyCancellable?
    
    init(){
        filterProductByType()
        
        searchCancellable = $searchText.removeDuplicates()
            .debounce(for: 0.5, scheduler: RunLoop.main)
            .sink(receiveValue: {str in
                if str != ""{
                    self.filterProductBySearch()
                }else{
                    self.searchedProducts = nil
                }
            })
    }
    
    func filterProductByType(){
        DispatchQueue.global(qos: .userInteractive).async {
            let results = self.products
            
                .lazy
                .filter{
                    product in
                    
                    return product.type == self.productType
                }.prefix(4)
            
            DispatchQueue.main.async{
                
                self.filteredProducts = results.compactMap({
                    product in
                    return product
                })
            }
        }
    }
    
    func filterProductBySearch(){
        DispatchQueue.global(qos: .userInteractive).async {
            let results = self.products
            
                .lazy
                .filter{
                    product in
                    
                    return product.title.lowercased().contains(self.searchText.lowercased())
                }
            
            DispatchQueue.main.async{
                
                self.searchedProducts = results.compactMap({
                    product in
                    return product
                })
            }
        }
    }
}


