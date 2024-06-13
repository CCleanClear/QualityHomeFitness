//
//  ContentView.swift
//  QualityHomeFitness
//
//  Created by Crystal Chan on 2/3/2024.
//

import SwiftUI

struct ContentView: View {
    @AppStorage("log_status") var logStatus: Bool = false
    var body: some View {
        if logStatus {
            withAnimation{
                MainView()
            }
        }else{
            LoginView()
        }
    }
}

#Preview {
    ContentView()
}
