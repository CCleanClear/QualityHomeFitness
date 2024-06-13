//
//  Product.swift
//  QualityHomeFitness
//
//  Created by Crystal Chan on 3/3/2024.
//

import SwiftUI

struct Home: View {
//    @Namespace var animation
//    @StateObject var homeData: HomeViewModel = HomeViewModel()
//    var body: some View {
//        ScrollView(.vertical, showsIndicators: false){
//            VStack(spacing: 15){
//                
//                ZStack{
//                    if homeData.searchActivated{
//                        SearchBar()
//                    }else{
//                        SearchBar().matchedGeometryEffect(id: "SEARCHBAR", in: animation)
//                    }
//                }
//                .frame(width: getRect().width / 1.6)
//                .padding(.horizontal,25)
//                .contentShape(Rectangle())
//                .onTapGesture {
//                    withAnimation(.easeInOut){
//                        homeData.searchActivated = true
//                    }
//                }
//                
//                Text("Quality Home Fitness Product")
//                    .font(.title).bold()
//                    .hAlign(.leading)
//                    .padding(.top)
//                    .padding(.horizontal,25)
//                
//                ScrollView(.horizontal, showsIndicators: false){
//                    HStack(spacing: 0){
//                        ForEach(ProductType.allCases ,id: \.self){ type in
//                            Button{
//                                withAnimation{
//                                    homeData.productType = type
//                                }
//                            } label: {
//                                Text(type.rawValue)
//                                    .font(.body)
//                                    .fontWeight(.semibold)
//                                    .foregroundColor(homeData.productType == type ? Color.yellow : Color.gray)
//                                    .padding(.bottom, 10)
//                                
//                                    .overlay(
//                                        ZStack{
//                                            if homeData.productType == type {
//                                                Capsule().fill(Color("C_Yellow"))
//                                                    .matchedGeometryEffect(id: "PRODUCTTAB", in: animation)
//                                                    .frame(height: 2)
//                                            } else{
//                                                Capsule().fill(Color.clear)
//                                                    .frame(height: 2)
//                                            }
//                                        }.padding(.horizontal, -5)
//                                        ,alignment:.bottom
//                                    )
//                            }
//                            //                            ProductTypeView(type: type)
//                        }.padding(.leading, 25)
//                        
//                    }
//                    .padding(.top,20)
//            }.padding(.top, 10)
//            
//            ScrollView(.horizontal, showsIndicators: false){
//                HStack(spacing: 25){
//                    ForEach(homeData.filteredProducts){
//                        product in
//                        ProductCardView(product: product)
//                    }
//                }
//                .padding(.horizontal,25)
//                .padding(.bottom)
//                .padding(.top,30)
//            }.padding(.top,10)
//                
//                Button {
//                    homeData.showMoreProductOnType.toggle()
//                } label: {
//                    Label{
//                        Image(systemName: "arrow.right")
//                    }icon: {
//                        Text("see more")
//                    }.font(.body).bold()
//                        .foregroundColor(Color.yellow)
//                    
//                }.hAlign(.trailing)
//                    .padding(.trailing)
//                    .padding(.top,10)
//                
//            }
//            
//            
//        }.frame(maxWidth: .infinity, maxHeight: .infinity)
//            .background(Color("C_Bg"))
//            .onChange(of: homeData.productType){
//                newValue in
//                homeData.filterProductByType()
//            }
//            .sheet(isPresented: $homeData.showMoreProductOnType){
//                
//            }content: {
//                MoreProductsView()
//            }
//        
//            .overlay(
//                ZStack{
//                    if homeData.searchActivated{
//                        SearchView(animation: animation).environmentObject(homeData)
//                    }
//                }
//            )
//        
//    }
//    
//    @ViewBuilder
//    func SearchBar()-> some View{
//        HStack(spacing: 15){
//            Image(systemName: "magnifyingglass")
//                .font(.title2)
//                .foregroundColor(.gray)
//            
//            TextField("Search", text: .constant(""))
//
//        }
//        .padding(.vertical,12)
//        .padding(.horizontal)
//        .background(
//            Capsule().strokeBorder(Color.gray,lineWidth: 0.8)
//        )
//    }
//    
//    @ViewBuilder
//    func ProductCardView(product: Product) -> some View {
//        VStack(spacing : 10){
//            Image(product.productImage)
//                .resizable()
//                .aspectRatio(contentMode: .fit)
//                .frame(width: getRect().width / 2.5, height: getRect().width / 2.5)
//            
//                .offset(y: -80)
//                .padding(.bottom,-80)
//            
//            Text(product.title)
//                .font(.body)
//                .fontWeight(.semibold)
//                .padding(.top)
//            
//            Text(product.subtitle).lineLimit(2)
//                .font(.body)
//                .foregroundColor(.gray)
//                .foregroundColor(.yellow)
//            
//            Text(product.price)
//                .font(.body)
//                .fontWeight(.bold)
//                .padding(.top,5)
//        }.frame(width: 170)
//        .padding(.horizontal,20)
//        .padding(.bottom,22)
//        .background(
//            Color.white.cornerRadius(25)
//        )
//        .padding(.top,80)
//    }
//   
//    
//    
//    @ViewBuilder
//    func ProductTypeView(type: ProductType) -> some View {
//        Button{
//            
//        } label: {
//            Text(type.rawValue)
//                .font(.body)
//                .fontWeight(.semibold)
//        }
//    }
//    
    
    @Namespace var animation
    @StateObject var homeData: HomeViewModel = HomeViewModel()
    
    var body: some View {
        ScrollView(.vertical, showsIndicators: false){
            VStack(spacing: 15){
                
                ZStack{
                    if homeData.searchActivated{
                        SearchBar()
                    }else{
                        SearchBar().matchedGeometryEffect(id: "SEARCHBAR", in: animation)
                    }
                }
                .frame(width: getRect().width / 1.6)
                .padding(.horizontal,25)
                .contentShape(Rectangle())
                .onTapGesture {
                    withAnimation(.easeInOut){
                        homeData.searchActivated = true
                    }
                }
                
                Text("Quality Home Fitness Product")
                    .font(.title).bold()
                    .hAlign(.leading)
                    .padding(.top)
                    .padding(.horizontal,25)
                
                ScrollView(.horizontal, showsIndicators: false){
                    HStack(spacing: 0){
                        ForEach(ProductType.allCases ,id: \.self){ type in
                            Button{
                                withAnimation{
                                    homeData.productType = type
                                }
                            } label: {
                                Text(type.rawValue)
                                    .font(.body)
                                    .fontWeight(.semibold)
                                    .foregroundColor(homeData.productType == type ? Color.yellow : Color.gray)
                                    .padding(.bottom, 10)
                                
                                    .overlay(
                                        ZStack{
                                            if homeData.productType == type {
                                                Capsule().fill(Color("C_Yellow"))
                                                    .matchedGeometryEffect(id: "PRODUCTTAB", in: animation)
                                                    .frame(height: 2)
                                            } else{
                                                Capsule().fill(Color.clear)
                                                    .frame(height: 2)
                                            }
                                        }.padding(.horizontal, -5)
                                        ,alignment:.bottom
                                    )
                            }
                            //                            ProductTypeView(type: type)
                        }.padding(.leading, 25)
                        
                    }
                    .padding(.top,20)
            }.padding(.top, 10)
            
            ScrollView(.horizontal, showsIndicators: false){
                HStack(spacing: 25){
                    ForEach(homeData.filteredProducts){
                        product in
                        ProductCardView(product: product)
                    }
                }
                .padding(.horizontal,25)
                .padding(.bottom)
                .padding(.top,30)
            }.padding(.top,10)
                
                Button {
                    homeData.showMoreProductOnType.toggle()
                } label: {
                    Label{
                        Image(systemName: "arrow.right")
                    }icon: {
                        Text("see more")
                    }.font(.body).bold()
                        .foregroundColor(Color.yellow)
                    
                }.hAlign(.trailing)
                    .padding(.trailing)
                    .padding(.top,10)
                
            }
            
            
        }.frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(Color("C_Bg"))
            .onChange(of: homeData.productType){
                newValue in
                homeData.filterProductByType()
            }
            .sheet(isPresented: $homeData.showMoreProductOnType){
                
            }content: {
//                MoreProductsView()
            }
        
            .overlay(
                ZStack{
                    if homeData.searchActivated{
                        SearchView(animation: animation).environmentObject(homeData)
                    }
                }
            )
        
    }
    
    @ViewBuilder
    func SearchBar()-> some View{
        HStack(spacing: 15){
            Image(systemName: "magnifyingglass")
                .font(.title2)
                .foregroundColor(.gray)
            
            TextField("Search", text: .constant(""))

        }
        .padding(.vertical,12)
        .padding(.horizontal)
        .background(
            Capsule().strokeBorder(Color.gray,lineWidth: 0.8)
        )
    }
    
    @ViewBuilder
    func ProductCardView(product: Product) -> some View {
        VStack(spacing : 10){
            Image(product.productImage)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: getRect().width / 2.5, height: getRect().width / 2.5)
            
                .offset(y: -80)
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
        }.frame(width: 170)
        .padding(.horizontal,20)
        .padding(.bottom,22)
        .background(
            Color.white.cornerRadius(25)
        )
        .padding(.top,80)
    }
   
    
    
    @ViewBuilder
    func ProductTypeView(type: ProductType) -> some View {
        Button{
            
        } label: {
            Text(type.rawValue)
                .font(.body)
                .fontWeight(.semibold)
        }
    }
    
   
}

#Preview {
    Home()
}
