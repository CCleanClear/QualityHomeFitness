//
//  FireReusableProductsView.swift
//  QualityHomeFitness
//
//  Created by jackychoi on 26/4/2024.
//

import SwiftUI
import Firebase

struct FireReusableProductsView: View {
    @State var fireProducts: [FireProduct] = []
    
    @State var isFetching: Bool = true
    
    var body: some View {
        ScrollView(.vertical,showsIndicators: false){
            LazyVStack{
                if isFetching{
                    ProgressView()
                        .padding(.top,30)
                }else{
                    if fireProducts.isEmpty{
                        Text("No Product's Found")
                            .font(.caption)
                            .foregroundColor(.gray)
                            .padding(.top,30)
                    }else{
                        Posts()
                            .padding(5)
                    }
                }
            }
        }
        .vAlign(.top)
        .refreshable {
            isFetching = true
            fireProducts = []
            await fetchPosts()
        }.task {
            guard fireProducts.isEmpty else{return}
            await fetchPosts()
        }
    }
    @ViewBuilder
    func Posts()->some View{
        ForEach(fireProducts){
            post in
            FirePostCardView(fireProducts: post){ updatedPost in
                
            }

            Divider()
                .padding(.horizontal,-15)
        }
    }
    
    /// - Fetching Post's
    func fetchPosts() async{
        do{
            var query: Query!
            /// 3. firebase collection
            query = Firestore.firestore().collection("Fitness")
                .limit(to: 100)
            let docs = try await query.getDocuments()
            let fetchedPosts = docs.documents.compactMap { doc -> FireProduct? in
                try? doc.data(as: FireProduct.self)
            }
            await MainActor.run(body: {
                fireProducts = fetchedPosts
                isFetching = false
            })
        }catch{
            print(error.localizedDescription)
        }
    }
}

