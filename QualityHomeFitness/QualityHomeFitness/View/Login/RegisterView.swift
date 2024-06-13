//
//  RegisterView.swift
//  QualityHomeFitness
//
//  Created by Crystal Chan on 2/3/2024.
//

import SwiftUI
import PhotosUI
import Firebase
import FirebaseFirestore
import FirebaseStorage

struct RegisterView: View {
    @State var emailID: String = ""
    @State var password: String = ""
    @State var userName: String = ""
    @State var userBio: String = ""
    @State var userBioLink: String = ""
    @State var userProfilePicData : Data?
    
    @Environment(\.dismiss) var dismiss
    @State var showImagePicker: Bool = false
    @State var photoItem: PhotosPickerItem?
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
            Text("Let's Register\nAccount")
                .foregroundColor(Color("O_Color"))
                .font(.largeTitle).bold()
                .hAlign(.leading)
                .frame(height: getRect().height / 9.5)
                .padding()
                .background(
                    Image("vector")
                        .resizable()
                        .scaledToFill()
                        //.aspectRatio(contentMode: .fill)
                        .background(
                ZStack{
                    Circle().strokeBorder(Color.white.opacity(0.5), lineWidth: 3)
                        .frame(width: 50, height: 50)
                        .blur(radius: 3)
                        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topTrailing)
                        .padding(30)
                    
                    Circle().strokeBorder(Color.white.opacity(0.5), lineWidth: 3)
                        .frame(width: 30, height: 30)
                        .blur(radius: 3)
                        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .bottomTrailing)
                        .padding(.horizontal,20)
                    
                    Circle().strokeBorder(Color.white.opacity(0.5), lineWidth: 3)
                        .frame(width: 23, height: 23)
                        .blur(radius: 3)
                        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topLeading)
                        .padding(.leading, 10)
                }
                )
            )
            ScrollView(.vertical, showsIndicators: false) {
                VStack(spacing: 10) {
                    
                    // MARK : for smaller size optimization
                    ViewThatFits {
                        ScrollView(.vertical, showsIndicators: false) {
                            HelperView()
                        }
                        HelperView()
                    }
                    
                    HStack {
                        Text("Already Have an account?")
                            .foregroundColor(.gray)
                        
                        Button("Login Now") {
                            dismiss()
                        }.fontWeight(.bold)
                            .foregroundColor(.yellow)
                    }
                    .font(.callout)
                    .vAlign(.bottom)
                }
                .vAlign(.top)
                .padding(15)
                .overlay(content: {LoadingView(show: $isLoading)})
                .photosPicker(isPresented: $showImagePicker, selection: $photoItem)
                .onChange(of: photoItem) { newValue in
                    if let newValue {
                        Task{
                            do{
                                guard let imageData = try await newValue.loadTransferable(type: Data.self)
                                else {
                                    return
                                }
                                await MainActor.run(body:{ userProfilePicData = imageData})
                            } catch{}
                        }
                    }
                }
                
                .alert(errorMessage, isPresented: $showError,actions: {})
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
                .background(Color.white
                .clipShape(CustomCorners(corners: [.topLeft,.topRight], radius: 25)))
                .ignoresSafeArea()
        }.frame(maxWidth: .infinity, maxHeight: .infinity)
            //.background(Color("C_Yellow"))
    }
        
    
    @ViewBuilder
    func HelperView() -> some View {
        VStack(spacing: 12) {
            ZStack {
                if let userProfilePicData, let image = UIImage(data: userProfilePicData) {
                    Image(uiImage: image)
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                }else {
                    Image("NullProfile")
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                }
            }.frame(width: 85, height: 85)
                .clipShape(Circle())
                .contentShape(Circle())
                .onTapGesture {
                    showImagePicker.toggle()
                }
            
            CustomTextField(icon: "person", title: "UserName", hint: "Alex", value: $userName)
                .padding(.top, 3)
                
            CustomTextField(icon: "envelope", title: "Email", hint: "xxxx@gmail.com", value: $emailID)
                .padding(.top, 3)
            
            CustomTextField(icon: "lock", title: "Password", hint: "", value: $password)
                .padding(.top, 3)
            
            CustomTextField(icon: "person.bubble", title: "About you", hint: "Introudce myself", value: $userBio)
            
            CustomTextField(icon: "link", title: "Bio Link (Optional)", hint: "bio link", value: $userBioLink)
                .padding(.top, 3)
            
            
            
            Button (action: registerUser){
                Text("Sign up")
                    .foregroundColor(.white)
                    .hAlign(.center)
                    .fillView(.yellow)
            }
            .disableWithOpacity(userName == "" || userBio == "" || emailID == "" || password == "" || userProfilePicData == nil)
            .padding(.top,10)
        }
    }
    
    func registerUser() {
        isLoading = true
        Task{
            do{
                // create account
                try await Auth.auth().createUser(withEmail: emailID, password: password)
                // upload profile photo into firebase storage
                guard let userUID = Auth.auth().currentUser?.uid else{return}
                guard let imageData = userProfilePicData else {return}
                let storageRef = Storage.storage().reference().child("Profile_Images").child(userUID)
                let _ = try await storageRef.putDataAsync(imageData)
                // download photo url
                let downloadURL = try await storageRef.downloadURL()
                // create user firestore
                let  user = User(username: userName, userBio: userBio, userBioLink: userBioLink, userUID: userUID, userEmail: emailID, userProfileURL: downloadURL)
                let _ = try Firestore.firestore().collection("Users").document(userUID).setData(from: user, completion: {error in
                    if error == nil {
                        print("Saved Successfully")
                        userNameStored = userName
                        self.userUID = userUID
                        profileURL = downloadURL
                        withAnimation{
                            logStatus = true
                        }
                    }
                })
            } catch{
                
                try await Auth.auth().currentUser?.delete()
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
    RegisterView()
}
