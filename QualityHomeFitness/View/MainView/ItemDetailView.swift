//
//  ItemDetailView.swift
//  QualityHomeFitness
//
//  Created by Crystal Chan on 2/5/2024.
//

import SwiftUI

struct ItemDetailView: View {
    
    let product: ResponseModel
    @State private var currentPage = 0
    var body: some View {
        VStack{
            VStack{
               
                
                if let url1 = product.picture1URL, let url2 = product.picture2URL {
                    TabView(selection: $currentPage) {
                        AsyncImage(url: url1) { image in
                            image
                                .resizable()
                                .aspectRatio(contentMode: .fill)
                                .frame(width: 150, height: 150)
                                .padding(.horizontal)
                                .offset(y: -12)
                        } placeholder: {
                            ProgressView()
                        }
                        
                        AsyncImage(url: url2) { image in
                            image
                                .resizable()
                                .aspectRatio(contentMode: .fill)
                                .frame(width: 150, height: 150)
                                .padding(.horizontal)
                                .offset(y: -12)
                        } placeholder: {
                            ProgressView()
                        }
                        .tag(1)
                    }
                    .tabViewStyle(PageTabViewStyle())
                    
                   
                    HStack(spacing: 8) {
                        ForEach(0..<2) { index in 
                            Circle()
                                .fill(index == currentPage ? Color.blue : Color.gray)
                                .frame(width: 8, height: 8)
                        }
                    }
                    .padding(.bottom) }else if let url = product.picture1URL ?? product.picture2URL {
                       
                        AsyncImage(url: url) { image in
                            image
                                .resizable()
                                .aspectRatio(contentMode: .fill)
                                .frame(width: 150, height: 150)
                        } placeholder: {
                            ProgressView()
                        }
                    }
                
            }
            .frame(height: getRect().height / 3)
            
            ScrollView(.vertical, showsIndicators: false){
                VStack(alignment: .leading, spacing: 15){
                    
                    HStack{
                        Text(product.title/*?.prefix(10)*/ ?? "")
                            .font(.title)
                            .fontWeight(.bold)
                            .foregroundColor(Color("Black"))
                            .lineLimit(2)
                            .truncationMode(.tail)
                        
                        
                        Spacer()
                        
                        Text("$\(product.price ?? "")" )
                            .font(.title)
                            .fontWeight(.bold)
                            .foregroundColor(Color("Black"))
                        
                    }.padding(.vertical, 10)
                    
                    HStack{
                        
                        Label{
                            Text(product.review ?? "")
                                .font(.callout)
                        } icon:{
                            Image(systemName: "star.fill")
                                .foregroundColor(.yellow)
                        }
                        .padding(.horizontal, 10)
                        .padding(.vertical, 5)
                        .background(RoundedRectangle(cornerRadius: 10)
                            .fill(Color.white)
                            .overlay(
                                RoundedRectangle(cornerRadius: 10)
                                    .strokeBorder(Color.black.opacity(0.2),lineWidth: 1)
                            ))
                        
                        
                        Spacer()
                        
                        Button(action: {
                            if let url = product.purlURL {
                                UIApplication.shared.open(url)
                            }
                        }) {
                            Image(systemName: "bag")
                                .font(.system(size: 24))
                                .foregroundColor(.brown)
                        }
                        
                        Button(action: {
                            if let productName = product.title {
                                let urlString = "https://www.amazon.com/s?k=\(productName)"
                                if let encodedString = urlString.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed),
                                    let url = URL(string: encodedString) {
                                    UIApplication.shared.open(url)
                                }
                            }
                        }) {
                            Image(systemName: "exclamationmark.magnifyingglass")
                                .font(.system(size: 24))
                                .foregroundColor(.brown)
                        }
                        
                        
                        .hAlign(.trailing)
                    }
                    
                    Text("By \(product.brand ?? "") ")
                        .font(.headline)
                        .fontWeight(.semibold)
                        .foregroundColor(.gray)
                    
                    
                    Text(product.short ?? "")
                        .font(.subheadline)
                        .lineSpacing(4)
                        .multilineTextAlignment(.leading)
                        .foregroundColor(.gray)
                    
                    Text("Description")
                        .font(.body).bold()
                        .padding(.top)
                    
                    Text(product.description ?? "-")
                        .font(.caption)
                        .lineSpacing(4)
                        .multilineTextAlignment(.leading)
                        .foregroundColor(.gray)
                    
                    Text("Dimensions: \(String(product.dimensions?.dropFirst() ?? "-"))")
                        .font(.body)
                        .foregroundColor(.gray)
                    
                    Text("ASIN: \(product.asin ?? "-")" )
                        .font(.body)
                        .foregroundColor(.gray)
                    
                    
                    Button{
                        
                    }label: {
                        Label{
                            Image(systemName: "arrow.right")
                        } icon: {
                            Text("Full description")
                        }.font(.body)
                            .foregroundColor(.yellow)
                    }
                    
                    Divider().overlay(
                        .gray
                    )
                    
                    
                    
                    HStack{
                        Text("Customer reviews")
                            .font(.body).bold()
                            .padding(.top)
                        Spacer()
                        Text(product.review ?? "")
                            .font(.callout)
                        Image(systemName: "star.fill")
                            .foregroundColor(.yellow)
                    }
                    
                    
                   
                        
                        Text(getReviewsExcludingFirstTwoWords(product.reviews ?? "--"))
                            .font(.callout)
                            .lineSpacing(8)
                            .multilineTextAlignment(.leading)
                            .padding(.top)
                        
                       
                    
                    
                    
                    
                    
                }.padding([.horizontal,.bottom], 10)
                    .padding(.top, 25)
                    .frame(maxWidth:.infinity, alignment: .leading)
                
                
            }.frame(maxWidth: .infinity, maxHeight: .infinity)
                .background(
                    Color("C_Bg")
                        .clipShape(CustomCorners(corners: [.topLeft, .topRight], radius: 25))
                        .ignoresSafeArea()
                )
            
        }
        .background(Color.white.ignoresSafeArea())
    }
    
    func getReviewsExcludingFirstTwoWords(_ reviews: String) -> String {
        let words = reviews.split(separator: " ")
        let remainingWords = words.dropFirst()
        return remainingWords.joined(separator: " ")
    }
    
}

#Preview {
    ItemDetailView(product: ResponseModel(id: "dfs", type: "fgs", title: "Watch", price: "100", brand: "dgfsg", short: "dgsg", description: "gdfg", asin: "fgg", review: "4.5", dimensions: "gfsgs", picture1Src: "https://m.media-amazon.com/images/I/61E8oy0vySL._AC_SX425_.jpg", picture2Src: "https://m.media-amazon.com/images/I/61E8oy0vySL._AC_SX425_.jpg", reviews: "dbgfjhgfsjg"))
}
