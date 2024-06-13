//
//  FitnessView.swift
//  QualityHomeFitness
//
//  Created by Crystal Chan on 1/5/2024.
//

import SwiftUI


struct FitnessView: View {
    @State var models: [ResponseModel] = []
    @State var selectProductType: ProductType2 = .All
    @State private var isLoading = true
    // @State var showMoreProductOnType: Bool = false
    
    @State private var searchQuery = ""
    @State private var filteredModels: [ResponseModel] = []
    
    @State private var showRecommendView = false
   
    
    
    var body: some View {
        
        NavigationView{
            ScrollView(.vertical){
                VStack(spacing: 15){
                    
                    HStack (spacing: 8){
                        
                        Text("Quality Home Fitness")
                            .font(.title).bold()
                            .foregroundColor(Color("Black"))
                            .hAlign(.leading)
                            .padding(.top)
                            .padding(.horizontal, 5)
                        
                        
                        
                        NavigationLink(destination: recommendView()){
                            Image(systemName: "megaphone")
                             .font(.system(size: 24))
                             .foregroundColor(.yellow)
                             .padding(.horizontal,5)
                        }
                        
                        
                        
                        
                    }.padding(.horizontal, 10)
                    
                    HStack{
                        SearchBar()
                            //.hAlign(.leading)
                            .frame(width: 280)
                            //.padding(.horizontal,10)
                            .contentShape(Rectangle())
                        
                        
                        Spacer()
                        
                            NavigationLink(destination: ClassificationView())
                           {
                            Image(systemName: "camera.on.rectangle")
//                                .resizable()
                                .renderingMode(.template)
                                .foregroundColor(.black)
                                .font(.system(size: 20))
                                .padding(12)
                                .background(
                                    RoundedRectangle(cornerRadius: 10, style: .continuous).fill(.white)
                                )
                        }
                        
                           
                        
                    }  .padding(.horizontal, 12)

                    
                    ScrollView(.horizontal){
                        HStack (spacing:0){
                            ForEach(ProductType2.allCases ,id: \.self){type in
                                VStack{
                                    Button(action:{
                                        withAnimation(.spring()){
                                            selectProductType = type
                                        }
                                    },label: {
                                        Text(type.description)
                                            .font(.system(size: 12,weight: .semibold))
                                        
                                            .padding(.trailing,5)
                                    })
                                }.frame(width: 100, height: 40)
                                    .background(Color.white)
                                    .overlay{
                                        Rectangle()
                                            .stroke(lineWidth: 2)
                                    }
                                    .cornerRadius(5)
                                    .shadow(color: .gray, radius: 3, x: 3, y: 3)
                                    .padding(.horizontal,3)
                                    .foregroundColor(type == selectProductType ? Color("C_Yellow"): .gray)
                               
                            }
                          
                        }
                        .padding(.horizontal,12)
                        .padding(.bottom,5)
                        .frame(height:80)
                        .vAlign(.top)
                        
                        
                    }
                    //.background(Color.white)
                    .cornerRadius(15)
                    .scrollIndicators(.hidden)
                    
                   
                    
                    
                    if selectProductType == .All{
                        AllItem()
                    }
                    else if selectProductType == .AbdominalWheel{
                        abdominalWeel()
                    }else if selectProductType == .IndoorPullUpBar{
                        Indoor()
                    } else if selectProductType == .Dumbbell{
                        Dummbell()
                    } else if selectProductType == .ElasticBand{
                        elasticBand()
                    } else if selectProductType == .ExerciseBike{
                        exerciseBike()
                    } else if selectProductType == .ExerciseMat{
                        exercissMat()
                    } else if selectProductType == .FitnessBoard{
                        fitnessBoard()
                    } else if selectProductType == .JumpRope{
                        jumpRope()
                    } else if selectProductType == .Kettlebell{
                        kettleBell()
                    } else if selectProductType == .Treadmill{
                        treadMill()
                    }
                }
                
            }.frame(maxWidth: .infinity, maxHeight: .infinity)
                .background(Color("C_Bg"))
        
        }.navigationBarBackButtonHidden(true)
    }
    
    @ViewBuilder
    func SearchBar()-> some View{
        HStack(spacing: 15) {
            TextField("Search", text: $searchQuery)
                .padding(.horizontal,3)
            
            Button(action: {
                performSearch()
            }) {
                Image(systemName: "magnifyingglass")
                    .foregroundColor(.gray)
            }
            
            if !searchQuery.isEmpty {
                Button(action: {
                    searchQuery = ""
                    filteredModels = models
                }) {
                    Image(systemName: "xmark.circle.fill")
                        .foregroundColor(.gray)
                }
            }
        }
        .padding(.vertical,12)
        .padding(.horizontal,12)
        .background(
            Capsule().strokeBorder(Color.gray,lineWidth: 0.8)
        )
        .hAlign(.leading)
    }
    
    func performSearch() {
        filteredModels = models.filter { model in
            guard let title = model.short, let brand = model.brand else { return false }
            let searchQueryLowercased = searchQuery.lowercased()
            return title.lowercased().localizedStandardContains(searchQueryLowercased)
            || brand.lowercased().localizedStandardContains(searchQueryLowercased)
        }
    }
    
    
    @ViewBuilder
    func Min_Prices() -> some View{
        ScrollView {
                LazyVGrid(columns: [GridItem(.adaptive(minimum: 150))], spacing: 20) {
                    ForEach(filteredModels.filter { model in
                        if let modelPrice = Double(model.price ?? ""), modelPrice < 50 {
                            return true
                        }
                        return false
                    }) { model in
                        NavigationLink(destination: ItemDetailView(product: model)) {
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
                                
                                HStack {
                                    Text(model.review ?? "")
                                        .font(.callout)
                                    Image(systemName: "star.fill")
                                        .foregroundColor(.yellow)
                                }
                                .hAlign(.center)
                                
                                Text("$\(model.price ?? "")" )
                                    .font(.callout)
                                    .fontWeight(.bold)
                            }
                            .padding(10)
                        }
                       
                        .background(Color.white)
                        .cornerRadius(20)
                    }
                }
                .padding()
            }
            .onAppear {
                NetworkManager.fetchData { models in
                    self.models = models
                    self.filteredModels = models.filter { model in
                        if let modelPrice = Double(model.price ?? ""), modelPrice < 50 {
                            return true
                        }
                        return false
                    }
                }
            }
            .background(Color("C_Bg"))
            .padding(.bottom, 5)
    }
    
    @ViewBuilder
    func Max_Prices() -> some View{
        ScrollView {
                LazyVGrid(columns: [GridItem(.adaptive(minimum: 150))], spacing: 20) {
                    ForEach(filteredModels.filter { model in
                        if let modelPrice = Double(model.price ?? ""), modelPrice > 100 {
                            return true
                        }
                        return false
                    }) { model in
                        NavigationLink(destination: ItemDetailView(product: model)) {
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
                                
                                HStack {
                                    Text(model.review ?? "")
                                        .font(.callout)
                                    Image(systemName: "star.fill")
                                        .foregroundColor(.yellow)
                                }
                                .hAlign(.center)
                                
                                Text("$\(model.price ?? "")" )
                                    .font(.callout)
                                    .fontWeight(.bold)
                            }
                            .padding(10)
                        }
                        
                        .background(Color.white)
                        .cornerRadius(20)
                    }
                }
                .padding()
            }
            .onAppear {
                NetworkManager.fetchData { models in
                    self.models = models
                    self.filteredModels = models.filter { model in
                        if let modelPrice = Double(model.price ?? ""), modelPrice > 100 {
                            return true
                        }
                        return false
                    }
                }
            }
            .background(Color("C_Bg"))
            .padding(.bottom, 5)
    }
    
    
    @ViewBuilder
    func recommendView() -> some View {
        ScrollView {
            Text("Recommend Product").font(.title).foregroundColor(Color("Black"))
                .hAlign(.center).padding(.top,10)
            
               LazyVGrid(columns: [GridItem(.adaptive(minimum: 150))], spacing: 20) {
                   
                   ForEach(0..<6) { _ in
                       ForEach(filteredModels.filter { model in
                           model.id == String(Int.random(in: 1...260))
                       }) { model in
                           NavigationLink(destination: ItemDetailView(product: model)) {
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
                                       .foregroundColor(.black)
                                       .font(.caption2)
                                       .padding(.top, 10)
                                   
                                   
                                   Text(model.brand ?? "")
                                       .padding(.vertical, 5)
                                       .foregroundColor(.gray)
                                   
                                   HStack {
                                       if let review = model.review {
                                           Text(review)
                                               .font(.callout)
                                               .foregroundColor(.black)
                                           Image(systemName: "star.fill")
                                               .foregroundColor(.yellow)
                                       }
                                   }
                                   .hAlign(.center)
                                   
                                   Text("$\(model.price ?? "")")
                                       .font(.callout)
                                       .foregroundColor(.black)
                                       .fontWeight(.bold)
                                   
                                   Text(model.type ?? "")
                                       .font(.callout)
                                       .padding(.vertical, 5)
                                       .foregroundColor(.gray)
                               }
                               .padding(10)
                               .background(Color.white)
                               .cornerRadius(20)
                           }
                       }
                   }
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
           .padding([.horizontal, .bottom], 5)
    }

 
    
    @ViewBuilder
    func AllItem() -> some View{
         ScrollView {
            LazyVGrid(columns: [GridItem(.adaptive(minimum: 150))], spacing: 20) {
                ForEach(filteredModels) { model in
                    NavigationLink(destination: ItemDetailView(product: model)) {
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
                            
                            
                            HStack {
                                Text(model.review ?? "")
                                    .font(.callout)
                                Image(systemName: "star.fill")
                                    .foregroundColor(.yellow)
                            }
                            .hAlign(.center)
                            
                            Text("$\(model.price ?? "")")
                                .font(.callout)
                                .fontWeight(.bold)
                                .foregroundColor(Color("Black"))
                        }
                        .padding(10)
                        .background(Color.white)
                        .cornerRadius(20)
                    }
                }
            }.padding(.horizontal,5)
        }
        
        .onAppear {
            isLoading = true
            NetworkManager.fetchData { models in
                self.models = models
                self.filteredModels = models
                isLoading = false
            }
            
            
        }
        .background(Color("C_Bg"))
        .padding([.horizontal, .bottom],5)
        .frame(height: 500)
        
    }
    
   
    

    
    
    @ViewBuilder
    func abdominalWeel() -> some View{
        ScrollView {
            LazyVGrid(columns: [GridItem(.adaptive(minimum: 150))], spacing: 20) {
                ForEach(filteredModels) { model in
                    NavigationLink(destination:ItemDetailView(product: model)){
                        if model.type == "abdominalWheel" {
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
                   
                    .background(Color.white)
                    .cornerRadius(20)
                }
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
    
    @ViewBuilder
    func Indoor() -> some View{
        ScrollView {
            LazyVGrid(columns: [GridItem(.adaptive(minimum: 150))], spacing: 20) {
                ForEach(filteredModels) { model in
                    if model.type == "indoorPull-upBar" {
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
    
    @ViewBuilder
    func elasticBand() -> some View{
        ScrollView {
            LazyVGrid(columns: [GridItem(.adaptive(minimum: 150))], spacing: 20) {
                ForEach(filteredModels) { model in
                    if model.type == "elasticBand" {
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
    
    @ViewBuilder
    func exerciseBike() -> some View{
        ScrollView {
            LazyVGrid(columns: [GridItem(.adaptive(minimum: 150))], spacing: 20) {
                ForEach(filteredModels) { model in
                    if model.type == "exerciseBike"{
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
    
    @ViewBuilder
    func exercissMat() -> some View{
        ScrollView {
            LazyVGrid(columns: [GridItem(.adaptive(minimum: 150))], spacing: 20) {
                ForEach(filteredModels) { model in
                    if model.type == "exercissMat"{
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
    
    @ViewBuilder
    func fitnessBoard() -> some View{
        ScrollView {
            LazyVGrid(columns: [GridItem(.adaptive(minimum: 150))], spacing: 20) {
                ForEach(filteredModels) { model in
                    if model.type == "fitnessBoard"{
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
    
    @ViewBuilder
    func jumpRope() -> some View{
        ScrollView {
            LazyVGrid(columns: [GridItem(.adaptive(minimum: 150))], spacing: 20) {
                ForEach(filteredModels) { model in
                    if model.type == "jumpRope"{
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
    
    @ViewBuilder
    func kettleBell() -> some View{
        ScrollView {
            LazyVGrid(columns: [GridItem(.adaptive(minimum: 150))], spacing: 20) {
                ForEach(filteredModels) { model in
                    if model.type == "kettleBell"{
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
    
    @ViewBuilder
    func treadMill() -> some View{
        ScrollView {
            LazyVGrid(columns: [GridItem(.adaptive(minimum: 150))], spacing: 20) {
                ForEach(filteredModels) { model in
                    if model.type == "treadMill"{
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




public struct ResponseModel: Codable, Identifiable {
    public var id: String? = ""
    var type: String? = ""
    var purl: String? = ""
    
    var purlURL: URL? {
        URL(string: purl ?? "")
    }
    var title: String? = ""
    var price: String? = ""
    var brand: String? = ""
    var short: String? = ""
    var description: String? = ""
    var asin: String? = ""
    var review: String? = ""
    var dimensions: String? = ""
    var picture1Src: String? = ""
    var picture2Src: String? = ""
    var reviews: String? = ""
    
    var picture1URL: URL? {
        URL(string: picture1Src ?? "")
    }
    
    var picture2URL: URL? {
        URL(string: picture2Src ?? "")
    }
    
   
}

#Preview {
    FitnessView()
}
