//
//  SettingRowView.swift
//  QualityHomeFitness
//
//  Created by Crystal Chan on 7/3/2024.
//

import SwiftUI

struct SettingsRowView: View {
    let imageName: String
    let title: String
    let tintColor: Color
    
    var body: some View {
        HStack (spacing: 12){
            Image(systemName: imageName)
                .imageScale(.small)
                .font(.title)
                .foregroundColor(tintColor)
            
            Text(title)
                .font(.subheadline)
                .foregroundColor(.black)
        }
    }
}

//#Preview {
//    SettingRowView()
//}
