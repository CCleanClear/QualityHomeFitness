//
//  Profile.swift
//  QualityHomeFitness
//
//  Created by Crystal Chan on 7/3/2024.
//

import SwiftUI

struct Profile: View {
    var body: some View {
        NavigationView{
            ScrollView(.vertical, showsIndicators: false){
                VStack{
                    Text("My Profile")
                        .font(.title).bold()
                        .hAlign(.leading)
                    VStack(spacing: 15){
                        Image("")
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                            .frame(width: 60, height: 60)
                            .clipShape(Circle())
                            .offset(y: -30)
                            .padding(.bottom, -30)
                        
                        Text("name")
                            .font(.title2)
                            .fontWeight(.semibold)
                        
                        HStack(alignment: .top, spacing: 10){
                            Image(systemName: "envelope")
                                .foregroundColor(.gray)
                                .rotationEffect(.init(degrees: 180))
                            
                            Text("text")
                                .font(.title3)
                        }.hAlign(.leading)
                        
                    }
                    .padding([.horizontal,.bottom])
                    .background(
                        Color.white
                            .cornerRadius(12)
                    )
                    .padding()
                    .padding(.top,40)
                }
                .padding(.horizontal,22)
                .padding(.vertical,20)
            }.navigationBarHidden(true)
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .background(
                    Color("C_Bg")
                    .ignoresSafeArea()
                )
            
            
        }
    }
}

#Preview {
    Profile()
}
