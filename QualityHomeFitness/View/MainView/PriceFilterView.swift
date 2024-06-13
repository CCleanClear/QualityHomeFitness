//
//  PriceFilterView.swift
//  QualityHomeFitness
//
//  Created by Crystal Chan on 12/5/2024.
//

import SwiftUI

struct PriceFilterView: View {
    @Binding var minPrice: Double
    @Binding var maxPrice: Double
    
    var body: some View {
        HStack {
            Text("Price Range:")
            
            TextField("Min", value: $minPrice, formatter: NumberFormatter())
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .frame(width: 70)
            
            Text("-")
            
            TextField("Max", value: $maxPrice, formatter: NumberFormatter())
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .frame(width: 70)
        }
        .padding(.horizontal)
    }
}

//#Preview {
//    PriceFilterView()
//}
