//
//  QualityHomeFitnessApp.swift
//  QualityHomeFitness
//
//  Created by Crystal Chan on 2/3/2024.
//

import SwiftUI
import Firebase

class SSLHandler: NSObject, ObservableObject, URLSessionDelegate {
    func urlSession(_ session: URLSession, didReceive challenge: URLAuthenticationChallenge, completionHandler: @escaping (URLSession.AuthChallengeDisposition, URLCredential?) -> Void) {
        completionHandler(.useCredential, URLCredential(trust: challenge.protectionSpace.serverTrust!))
    }
}

@main
struct QualityHomeFitnessApp: App {
//    @StateObject var viewModel = ViewModel()
    @StateObject var sslHandler = SSLHandler()
    
    init() {
        FirebaseApp.configure()
    }
    var body: some Scene {
        WindowGroup {
            ContentView()
//                            .environmentObject(viewModel)
                            .onAppear {
                                let config = URLSessionConfiguration.default
                                                   let session = URLSession(configuration: config, delegate: sslHandler, delegateQueue: nil)
                            }
        }
    }
}
