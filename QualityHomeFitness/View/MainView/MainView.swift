//
//  MainView.swift
//  QualityHomeFitness
//
//  Created by Crystal Chan on 2/3/2024.
//

import SwiftUI

struct MainView: View {
    @State var currentTab: Tab = .Home
    
    init() {
        UITabBar.appearance().isHidden = true
    }
    var body: some View {

        
        VStack(spacing: 0){
            TabView(selection: $currentTab) {
            
            
                FitnessView()
                    .tag(Tab.Home)
                
                
               ListView()
                    .tag(Tab.List)
                
              
                ProfileView()
                    .tag(Tab.Profile)
            
            }
            
            HStack(spacing: 0){
                ForEach(Tab.allCases,id: \.self){ tab in
                    
                    Button {
                        currentTab = tab
                    } label: {
                        Image(systemName: tab.rawValue)
                            .resizable()
                            .renderingMode(.template)
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 22, height: 22)
                            .background(
                                Circle()
                                    .foregroundColor(Color.yellow.opacity(0.15))
                                    .cornerRadius(5)
                                    .frame(width: 40, height: 40)
                                    .blur(radius: 5)
                                    .padding(-7)
                                    .opacity(currentTab == tab ? 1 : 0)
                            )
                            .frame(maxWidth: .infinity)
                            .foregroundColor(currentTab == tab ? Color.yellow : Color.black.opacity(0.3))
                    }
                    
                }
            }
            .padding([.horizontal,.top])
            .padding(.bottom, 15)
        }
    }
}

enum Tab: String, CaseIterable {
    case Home = "dumbbell.fill"
    //case Liked = "heart.fill"
    case List = "list.bullet.clipboard.fill"
    case Profile = "person.fill"
    //case Product = "gym.bag"
}


#Preview {
    MainView()
}
