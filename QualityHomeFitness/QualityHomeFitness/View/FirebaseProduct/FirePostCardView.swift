//
//  FirePostCardView.swift
//  QualityHomeFitness
//
//  Created by jackychoi on 26/4/2024.
//

import SwiftUI
import SDWebImageSwiftUI
import Firebase
import FirebaseStorage

struct FirePostCardView: View {
    var fireProducts: FireProduct
    var onUpdate: (FireProduct) -> ()
    
    @AppStorage("user_UID") private var userUID: String = ""
    @State private var docListner: ListenerRegistration?
    var body: some View {
        VStack(alignment:.leading,spacing: 6){
            Text(fireProducts.asin)
                .font(.callout)
                .fontWeight(.semibold)
                .foregroundColor(.black)
                .padding()
            Text(fireProducts.brand)
                .font(.callout)
                .fontWeight(.semibold)
                .foregroundColor(.black)
                .padding()
            Text(fireProducts.dimensions)
                .font(.callout)
                .fontWeight(.semibold)
                .foregroundColor(.black)
                .padding()
            Text(fireProducts.title)
                .font(.callout)
                .fontWeight(.semibold)
                .foregroundColor(.black)
                .padding()
            Text(fireProducts.review)
                .font(.callout)
                .fontWeight(.semibold)
                .foregroundColor(.black)
                .padding()
        }
        .onAppear{
            if docListner == nil{
                guard let postID = fireProducts.id else{return}
                docListner = Firestore.firestore().collection("Fitness").document(postID).addSnapshotListener({
                    snapshot, error in
                    if let snapshot{
                        if snapshot.exists{
                            if let updatedPost = try? snapshot.data(as: FireProduct.self){
                                onUpdate(updatedPost)
                            }
                        }
                    }
                })
            }
        }
        .onDisappear{
            if let docListner{
                docListner.remove()
                self.docListner = nil
            }
        }
    }
}
