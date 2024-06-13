//
//  MoreProductsView.swift
//  QualityHomeFitness
//
//  Created by Crystal Chan on 5/3/2024.
//

import SwiftUI

struct MoreProductsView: View {
    var models: [ResponseModel]
    var selectProductType: ProductType2
    
    
    var body: some View {
        ScrollView(.vertical, showsIndicators: false){
            VStack{
                Text("More Products")
                    .font(.title2).bold()
                    .foregroundColor(.black)
                    .hAlign(.leading)
            }.padding()
                .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topLeading)
                .background(Color.accentColor.ignoresSafeArea())
            
            
//            if selectProductType == .All{
//                AllItemDetail()
//            }
            //            else if selectProductType == .AbdominalWheel{
            //                abdominalWeelDetail()
            //            }else if selectProductType == .IndoorPullUpBar{
            //                IndoorDetail()
            //            } else if selectProductType == .Dumbbell{
            //                DummbellDetail()
            //            } else if selectProductType == .ElasticBand{
            //                elasticBandDetail()
            //            } else if selectProductType == .ExerciseBike{
            //                exerciseBikeDetail()
            //            } else if selectProductType == .ExerciseMat{
            //                exercissMatDetail()
            //            } else if selectProductType == .FitnessBoard{
            //                fitnessBoardDetail()
            //            } else if selectProductType == .JumpRope{
            //                jumpRopeDetail()
            //            } else if selectProductType == .Kettlebell{
            //                kettleBellDetail()
            //            } else if selectProductType == .Treadmill{
            //                treadMillDetail()
            //            }
        }
        
    }
    
//    @ViewBuilder
//    func AllItemDetail() -> some View{
//        ScrollView(.horizontal, showsIndicators: false) {
//            LazyVGrid(columns: [GridItem(.flexible()), GridItem(.flexible())], spacing: 20) { // Two-column grid
//                ForEach(models.filter { $0.productType == type }) { model in
//                    VStack {
//                        // Image display (using either picture1URL or picture2URL)
//                        if let url = model.picture1URL ?? model.picture2URL {
//                            AsyncImage(url: url) { image in
//                                image
//                                    .resizable()
//                                    .aspectRatio(contentMode: .fill)
//                                    .frame(width: 150, height: 150) // Adjust size as needed
//                            } placeholder: {
//                                ProgressView()
//                            }
//                        }
//                        
//                        // Text details
//                        Text(model.short?.prefix(35) ?? "")
//                            .font(.caption2)
//                            .padding(.top, 10)
//                        
//                        Text(model.brand ?? "")
//                            .padding(.vertical, 5)
//                            .foregroundColor(.gray)
//                        
//                        HStack{
//                            Text(model.review ?? "")
//                                .font(.callout)
//                            Image(systemName: "star.fill")
//                                .foregroundColor(.yellow)
//                        }.hAlign(.center)
//                        
//                        Text("$\(model.price ?? "")" )
//                            .font(.callout)
//                            .fontWeight(.bold)
//                    }
//                    .padding(10)
//                    // Adjust padding as needed
//                    
//                    .background(Color.white)
//                    .cornerRadius(20)
//                }
//                .padding() // Add padding around the entire HStack
//            }
//            }
//            
//            //.vAlign(.top)
//            .background(Color("C_Bg"))
//        }
        
    }
    
    //#Preview {
    //    MoreProductsView()
    //}
