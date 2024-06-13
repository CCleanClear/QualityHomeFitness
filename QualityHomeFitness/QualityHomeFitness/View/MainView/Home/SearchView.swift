//
//  SearchView.swift
//  QualityHomeFitness
//
//  Created by Crystal Chan on 7/3/2024.
//

import SwiftUI

struct SearchView: View {
    var animation: Namespace.ID
    
    @EnvironmentObject var homeData: HomeViewModel
    
    @FocusState var startTF:Bool
    var body: some View {
        VStack(spacing: 0){
            HStack(spacing:20){
                Button{
                    withAnimation{
                        homeData.searchActivated = false
                    }
                    homeData.searchText = ""
                }label: {
                    Image(systemName: "arrow.left")
                        .font(.title2)
                        .foregroundColor(Color.black.opacity(0.7))
                }
                
                HStack(spacing: 15){
                    Image(systemName: "magnifyingglass")
                        .font(.title2)
                        .foregroundColor(.gray)
                    
                    TextField("Search", text: $homeData.searchText)
                        .focused($startTF)
                        .textCase(.lowercase)
                        .disableAutocorrection(true)
                }
                .padding(.vertical,12)
                .padding(.horizontal)
                .background(
                    Capsule().strokeBorder(Color("C_Yellow"),lineWidth: 1.5)
                )
                .matchedGeometryEffect(id: "SEARCHBAR", in: animation)
                .padding(.trailing,20)
            }
            .padding([.horizontal])
            .padding(.top)
            .padding(.bottom,10)
            
            if let products = homeData.searchedProducts{
                if products.isEmpty{
                    VStack(spacing:10){
                        Image("NotFound")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .padding(.top, 60)
                        
                        Text("Item Not Found")
                            .font(.title2).bold()
                        
                        Text("Try a more generic search term or try looking for alternative products.")
                            .font(.title2).bold()
                            .foregroundColor(.gray)
                            .multilineTextAlignment(.center)
                            .padding(.horizontal,30)
                    }
                    .padding()
                }else{
                    ScrollView(.vertical, showsIndicators: false){
                        VStack(spacing:0){
                            
                            Text("Found \(products.count) results")
                                .font(.title2).bold()
                                .padding(.vertical)
                            StaggeredGrid(columns: 2, spacing: 20,list: products){
                                product in
                                
                                ProductCardView(product: product)
                            }
                        }
                        .padding()
                    }
                }
            }else{
                ProgressView()
                    .padding(.top,30)
                    .opacity(homeData.searchText == "" ? 0 : 1)
            }
        }.frame(maxWidth: .infinity, maxHeight: .infinity,alignment: .top)
            .background(
                Color("C_Bg")
                    .ignoresSafeArea()
            )
            .onAppear{
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.1){
                    startTF = true
                }
            }
    }
    
    @ViewBuilder
    func ProductCardView(product: Product) -> some View {
        VStack(spacing : 10){
            Image(product.productImage)
                .resizable()
                .aspectRatio(contentMode: .fit)
            
                .offset(y: -50)
                .padding(.bottom,-80)
            
            Text(product.title)
                .font(.body)
                .fontWeight(.semibold)
                .padding(.top)
            
            Text(product.subtitle).lineLimit(2)
                .font(.body)
                .foregroundColor(.gray)
                .foregroundColor(.yellow)
            
            Text(product.price)
                .font(.body)
                .fontWeight(.bold)
                .padding(.top,5)
        }.frame(width: 140)
        .padding(.horizontal,20)
        .padding(.bottom,22)
        .background(
            Color.white.cornerRadius(25)
        )
        .padding(.top,50)
    }
}

#Preview {
   Home()
}
