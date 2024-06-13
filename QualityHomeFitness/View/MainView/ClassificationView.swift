//
//  ClassificationView.swift
//  QualityHomeFitness
//
//  Created by Crystal Chan on 14/5/2024.
//

import SwiftUI

struct ClassificationView: View {
    @State private var isPresented = false
    @State private var sourceType = UIImagePickerController.SourceType.photoLibrary
    @State private var image: UIImage?
    
    
    @State var models: [ResponseModel] = []
    @State var selectProductType: ProductType2 = .All
    @State private var isLoading = true
    // @State var showMoreProductOnType: Bool = false
    
    @State private var searchQuery = ""
    @State private var filteredModels: [ResponseModel] = []
    
    @ObservedObject var classification = ImageClassification()
    
    var body: some View {
        VStack (alignment: .leading, spacing: 10){
            Text("Product Classification")
                .font(.title).bold()
                .foregroundColor(Color("Black"))
        }.frame(maxWidth: .infinity, alignment: .leading)
            .padding(.horizontal, 10)
        ZStack(alignment: .bottom) {
            if let image = self.image {
                Image(uiImage: image)
                    .resizable()
                    .scaledToFill()
                    .frame(minWidth: 0, maxWidth: .infinity)
            }
            else {
                Image(uiImage: UIImage())
                    .resizable()
                    .scaledToFill()
                    .frame(minWidth: 0, maxWidth: .infinity)
            }
            
            VStack {
                Text(classification.classificationLabel)
                    .padding(20)
                    .foregroundColor(.black)
                    .background(
                        RoundedRectangle(cornerRadius: 10).stroke(Color(.black),lineWidth: 2)
                            .background(Color.white).cornerRadius(9)
                    )
                
                // select camera or photo library
                Menu {
                    Button(action: {
                        self.isPresented.toggle()
                        self.sourceType = .camera
                    }, label: {
                        Text("Take Photo")
                    })
                    
                    Button(action: {
                        self.isPresented.toggle()
                        self.sourceType = .photoLibrary
                    }, label: {
                        Text("Choose Photo")
                    })
                } label: {
                    Image(systemName: "camera.fill")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 30, height: 30, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                        .padding(20)
                }
                .sheet(isPresented: $isPresented, onDismiss: {
                    // Classify the image
                    if let image = self.image {
                        classification.updateClassifications(for: image)
                    }
                }, content: {
                    ImagePicker(sourceType: self.sourceType, image: $image)
                })
            }
        }
        }
    
    @ViewBuilder
    func Dummbell() -> some View{
        ScrollView {
            LazyVGrid(columns: [GridItem(.adaptive(minimum: 150))], spacing: 20) {
                ForEach(filteredModels) { model in
                    if model.type == "dumbbell" {
                        NavigationLink(destination:ItemDetailView(product: model)){
                            VStack {
                                
                                if let url = model.picture1URL ?? model.picture2URL {
                                    AsyncImage(url: url) { image in
                                        image
                                            .resizable()
                                            .aspectRatio(contentMode: .fill)
                                            .frame(width: 150, height: 150)
                                    } placeholder: {
                                        ProgressView()
                                    }
                                }
                                
                               
                                Text(model.short?.prefix(35) ?? "")
                                    .font(.caption2)
                                    .padding(.top, 10)
                                
                                Text(model.brand ?? "")
                                    .padding(.vertical, 5)
                                    .foregroundColor(.gray)
                                
                                HStack{
                                    Text(model.review ?? "")
                                        .font(.callout)
                                    Image(systemName: "star.fill")
                                        .foregroundColor(.yellow)
                                }.hAlign(.center)
                                
                                Text("$\(model.price ?? "")" )
                                    .font(.callout)
                                    .fontWeight(.bold)
                            }
                            .padding(10)
                        }
                    }
                    
                }
                .background(Color.white)
                .cornerRadius(20)
            }
            .padding()
        }
        .onAppear {
            NetworkManager.fetchData { models in
                self.models = models
            }
            filteredModels = models
        }
        .vAlign(.top)
        .background(Color("C_Bg"))
        .frame(height: 500)
        .padding([.horizontal, .bottom],5)
    }
    }
    
    // MARK: - ImagePicker
    struct ImagePicker: UIViewControllerRepresentable {
        var sourceType: UIImagePickerController.SourceType = .photoLibrary
        
        func makeUIViewController(context: UIViewControllerRepresentableContext<ImagePicker>) -> UIImagePickerController {
            let imagePicker = UIImagePickerController()
            imagePicker.allowsEditing = false
            imagePicker.sourceType = sourceType
            imagePicker.delegate = context.coordinator
            return imagePicker
        }
        
        func updateUIViewController(_ uiViewController: UIImagePickerController, context: UIViewControllerRepresentableContext<ImagePicker>) {
            
        }
        
        // MARK: - Using Coordinator to Adopt the  UIImagePickerControllerDelegate Protocol
        @Binding var image: UIImage?
        @Environment(\.presentationMode) private var presentationMode
        
        func makeCoordinator() -> Coordinator {
            Coordinator(self)
        }
        
        final class Coordinator: NSObject, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
            var parent: ImagePicker
            
            init(_ parent: ImagePicker) {
                self.parent = parent
            }
            
            func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
                
                if let image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
                    parent.image = image
                }
                
                parent.presentationMode.wrappedValue.dismiss()
            }
        }
    }
    
   

#Preview {
    ClassificationView()
}
