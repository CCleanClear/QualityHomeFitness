//
//  LoginView.swift
//  QualityHomeFitness
//
//  Created by Crystal Chan on 2/3/2024.
//

import SwiftUI
import Firebase
import FirebaseFirestore
import FirebaseStorage

struct LoginView: View {
    @State var emailID: String = ""
    @State var password: String = ""
    
    @State var createAccount: Bool = false
    @State var showError: Bool = false
    @State var errorMessage: String = ""
    @State var isLoading: Bool = false
    
    //    MARK: userDefaults
    @AppStorage("log_status") var logStatus: Bool = false
    @AppStorage("user_profile_url") var profileURL: URL?
    @AppStorage("user_name") var userNameStored: String  = ""
    @AppStorage("user_UID") var userUID: String = ""
    
    var body: some View {
        VStack {
            Text("Quality \nHome Fitness")
                .foregroundColor(Color("O_Color"))
                .font(.largeTitle).bold()
                .hAlign(.leading)
                .frame(height: getRect().height / 4.5)
                .padding()
                .background(
                    Image("vector")
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .background(
                ZStack{
                    Circle().strokeBorder(Color.white.opacity(0.5), lineWidth: 3)
                        .frame(width: 50, height: 50)
                        .blur(radius: 3)
                        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topTrailing)
                        .padding(30)
                    
                    Circle().strokeBorder(Color.white.opacity(0.4), lineWidth: 3)
                        .frame(width: 30, height: 30)
                        .blur(radius: 3)
                        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .bottomTrailing)
                        .padding(.horizontal,30)
                    
                    Circle().strokeBorder(Color.white.opacity(0.4), lineWidth: 3)
                        .frame(width: 25, height: 25)
                        .blur(radius: 3)
                        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topLeading)
                        .padding(.leading, 20)
                }
                )
            )
            
            ScrollView(.vertical, showsIndicators: false) {
                
                VStack(spacing: 15){
                    Text("Login")
                        .font(.title).bold()
                        .hAlign(.leading)
                    
                    CustomTextField(icon: "envelope", title: "Email", hint: "xxxx@gmail.com", value: $emailID)
                        .padding(.top, 30)
                    
                    CustomTextField(icon: "lock", title: "Password", hint: "", value: $password)
                        .padding(.top, 30)
                    
                    Button("Reset password?", action: resetPassword)
                        .font(.callout)
                        .fontWeight(.medium)
                        .tint(.yellow)
                        .padding(.top, 8)
                        .hAlign(.leading)
                    
                    
                    Button(action: loginUser){
                        Text("Sign in")
                            .foregroundColor(.white)
                            .hAlign(.center)
                            .fillView(.yellow)
                    }
                    .padding(.top,10)
                    
                }.padding(30)
                
                
                
                HStack {
                    Text("Don't have an account?")
                        .foregroundColor(.gray)
                    
                    Button("Register Now") {
                        createAccount.toggle()
                    }.fontWeight(.bold)
                        .foregroundColor(.yellow)
                }
                .font(.callout)
            }.frame(maxWidth: .infinity, maxHeight: .infinity)
                .background(Color.white
                .clipShape(CustomCorners(corners: [.topLeft,.topRight], radius: 25)))
                .ignoresSafeArea()
        }
        .vAlign(.top)
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(
//            Color("C_Yellow")
        )
        .overlay(content: {
            LoadingView(show: $isLoading)
        })
        
        
        // MARK: Register View VIA sheets
        .fullScreenCover(isPresented: $createAccount){
            RegisterView()
        }
        .alert(errorMessage, isPresented: $showError, actions: {})
    }
    func loginUser() {
        isLoading = true
        Task{
            do{
                try await Auth.auth().signIn(withEmail: emailID, password: password)
                print("User Found")
                try await fetchUser()
            }catch{
               await setError(error)
            }
        }
    }
    
    //MARK: if user if found then fetching user data from firestore
    func fetchUser()async throws {
        guard let userID = Auth.auth().currentUser?.uid else {return}
        let user = try await Firestore.firestore().collection("Users").document(userID).getDocument(as: User.self)
    // MARK: ui updating must be run on main thread
        await MainActor.run(body: {
            userUID = userID
            userNameStored = user.username
            profileURL = user.userProfileURL
            withAnimation{
                logStatus = true
            }
        })
    }
    
    func resetPassword() {
        Task{
            do{
                try await Auth.auth().sendPasswordReset(withEmail: emailID)
                print("Link Sent")
            }catch{
               await setError(error)
            }
        }
    }
    
    func setError(_ error: Error)async {
        await MainActor.run(body: {
            errorMessage = error.localizedDescription
            showError.toggle()
            isLoading = false
        })
    }
}





#Preview {
    LoginView()
//    RegisterView()
}



