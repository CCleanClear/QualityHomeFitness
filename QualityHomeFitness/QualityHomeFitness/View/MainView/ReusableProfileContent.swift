//
//  ReusableProfileContent.swift
//  QualityHomeFitness
//
//  Created by Crystal Chan on 2/3/2024.
//

import SwiftUI
import SDWebImageSwiftUI

struct ReusableProfileContent: View {
    var user: User
    var body: some View {
        ScrollView(.vertical, showsIndicators: false){
            LazyVStack{
                VStack(spacing: 15){
                    WebImage(url: user.userProfileURL).placeholder{
                        Image("NullProfile")
                            .resizable()
                    }
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: 60, height: 60)
                    .clipShape(Circle())
                    .offset(y: -30)
                    .padding(.bottom, -30)
                    
                        Text(user.username)
                        .font(.title2)
                        .fontWeight(.semibold)
                    
                    HStack(alignment: .top, spacing: 10){
                        Image(systemName: "text.bubble")
                            .foregroundColor(.gray)
                            .rotationEffect(.init(degrees: 180))
                        
                        Text(user.userBio)
                            .font(.title3)
                            .lineLimit(3)
                        
                        if let bioLink = URL(string: user.userBioLink){
                            Link(user.userBioLink, destination: bioLink)
                                .font(.callout)
                                .tint(.blue)
                                .lineLimit(1)
                    }
                    }.hAlign(.leading)
                    
                        
                    
                }.padding([.horizontal,.bottom])
                    .background(
                        Color.white
                            .cornerRadius(12)
                    )
                    .padding()
                    .padding(.top,40)
                
            }
            .padding(15)
        }
    }
}
