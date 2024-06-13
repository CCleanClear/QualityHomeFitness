//
//  ProfileView.swift
//  QualityHomeFitness
//
//  Created by Crystal Chan on 2/3/2024.
//

import SwiftUI
import Firebase
import FirebaseStorage
import FirebaseFirestore

struct ProfileView: View {
    @State private var myProfile: User?
    @AppStorage("log_status") var logStatus: Bool = false
    
    @State var errorMessage: String = ""
    @State var showError: Bool =  false
    @State var isLoading: Bool = false
    
    var body: some View {
        NavigationView{
            ScrollView(.vertical, showsIndicators: false){
                VStack{
                    Text("My Profile")
                        .font(.title).bold()
                        .hAlign(.leading)
                    VStack{
                        if let myProfile{
                            ReusableProfileContent(user: myProfile)
                                .refreshable {
                                    self.myProfile = nil
                                    await fetchUserDate()
                                }
                        }else{
                            ProgressView()
                        }
                    }
                    Text("Account").font(.title2).bold()
                        .hAlign(.leading)
                    VStack{
                        Button(action: logOutUser){
                            SettingsRowView(imageName: "rectangle.portrait.and.arrow.right", title: "Sign out", tintColor: .red)
                        }.hAlign(.leading)
                            .padding(.top,10)
                        
                    }.padding(.leading,5)
                        .padding([.horizontal,.bottom])
                        .background(
                            Color.white
                                .cornerRadius(12)
                        )
                        .padding(.horizontal)
                    
                    VStack{
                        Button(action: deleteAccount){
                            SettingsRowView(imageName: "xmark.circle.fill", title: "Delete Account", tintColor: .red)
                        }.hAlign(.leading)
                            .padding(.top,10)
                    }.padding(.leading,5)
                        .padding([.horizontal,.bottom])
                        .background(
                            Color.white
                                .cornerRadius(12)
                        )
                        .padding()
                    
                    

                }.padding(.leading, 10)
                }.navigationBarHidden(true)
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .background(Color("C_Bg").ignoresSafeArea())
        }
        .overlay{
            LoadingView(show: $isLoading)
        }
        .alert(errorMessage, isPresented: $showError){
        
        }
        .task {
            if myProfile != nil {return}
            await fetchUserDate()
        }
    }
    
    func fetchUserDate() async {
        guard let userUID = Auth.auth().currentUser?.uid else {return}
        guard let user = try? await Firestore.firestore().collection("Users").document(userUID).getDocument(as: User.self) else {return}
        await MainActor.run(body: {
            myProfile = user
        })
                
    }
                
    
    func logOutUser() {
        try? Auth.auth().signOut()
        logStatus = false
    }
    
    func deleteAccount() {
        isLoading = true
        Task{
            do{
                guard let userID = Auth.auth().currentUser?.uid else {return}
                let reference = Storage.storage().reference().child("Profile_Images").child(userID)
                try await reference.delete()
                
                try await Firestore.firestore().collection("Users").document(userID).delete()
                try await Auth.auth().currentUser?.delete()
                logStatus = false
            } catch{
                await setError(error)
            }
        }
    }
    
    func setError(_ error: Error) async{
        await MainActor.run(body: {
            isLoading = false
            errorMessage = error.localizedDescription
            showError.toggle()
        })
    }
    
}

#Preview {
    ProfileView()
}
