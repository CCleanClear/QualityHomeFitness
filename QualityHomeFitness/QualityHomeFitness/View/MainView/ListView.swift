//
//  ListView.swift
//  QualityHomeFitness
//
//  Created by Crystal Chan on 14/5/2024.
//

import SwiftUI

struct ListView: View {
    @State var models: [ResponseModel] = []
    @State var selectProductType: ProductType2 = .All
    @State private var isLoading = true
    // @State var showMoreProductOnType: Bool = false
    @State var filterOption = "<50"
    @State private var searchQuery = ""
    @State private var filteredModels: [ResponseModel] = []
    
    
    var body: some View {
        NavigationView{
            ScrollView(.vertical){
                
                
                HStack (spacing : 10){
                    
                    Text("Cost")
                        .font(.title)
                        .fontWeight(.semibold)
                        .foregroundColor(Color("Black"))
                        .padding(.horizontal, 5)
                    
                    Spacer()
                               
                    Button{
                        filterOption = "<50"
                    }label: {
                        Text("<50")
                            .font(.callout)
                            .padding()
                            .background(RoundedRectangle(cornerRadius: 10)
                                .fill(Color.white)
                                .overlay(
                                    RoundedRectangle(cornerRadius: 10)
                                        .strokeBorder(Color.black.opacity(0.2),lineWidth: 2)
                                ))
                    }.foregroundColor(filterOption == "<50" ? Color("Black"): .gray)
                    
                    
                    Button{
                        filterOption = ">80"
                    }label: {
                        Text(">80")
                            .font(.callout)
                            .padding()
                            .background(RoundedRectangle(cornerRadius: 10)
                                .fill(Color.white)
                                .overlay(
                                    RoundedRectangle(cornerRadius: 10)
                                        .strokeBorder(Color.black.opacity(0.2),lineWidth: 2)
                                ))
                    }.foregroundColor(filterOption == ">80" ? Color("Black"): .gray)
                    
                    
                }.hAlign(.trailing)
                    .padding(.horizontal,5)
                
                
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
                
                .cornerRadius(15)
                .scrollIndicators(.hidden)
                
                
               
                
               
                
                if filterOption == "<50" {
                    
                    if selectProductType == .All{
                        Min_Prices()
                    }
                    else if selectProductType == .AbdominalWheel{
                        abdominalWeel_Min()
                    }else if selectProductType == .IndoorPullUpBar{
                        Indoor_Min()
                    } else if selectProductType == .Dumbbell{
                        Dummbell_Min()
                    } else if selectProductType == .ElasticBand{
                        elasticBand_Min()
                    } else if selectProductType == .ExerciseBike{
                        exerciseBike_Min()
                    } else if selectProductType == .ExerciseMat{
                        exercissMat_Min()
                    } else if selectProductType == .FitnessBoard{
                        fitnessBoard_Min()
                    } else if selectProductType == .JumpRope{
                        jumpRope_Min()
                    } else if selectProductType == .Kettlebell{
                        kettleBell_Min()
                    } else if selectProductType == .Treadmill{
                        treadMill_Min()
                    }
                    
                    
                } else if filterOption == ">80"{
                    if selectProductType == .All{
                        Max_Prices()
                    }
                    else if selectProductType == .AbdominalWheel{
                        abdominalWeel_Max()
                    }else if selectProductType == .IndoorPullUpBar{
                        Indoor_Max()
                    } else if selectProductType == .Dumbbell{
                        Dummbell_Max()
                    } else if selectProductType == .ElasticBand{
                        elasticBand_Max()
                    } else if selectProductType == .ExerciseBike{
                        exerciseBike_Max()
                    } else if selectProductType == .ExerciseMat{
                        exercissMat_Max()
                    } else if selectProductType == .FitnessBoard{
                        fitnessBoard_Max()
                    } else if selectProductType == .JumpRope{
                        jumpRope_Max()
                    } else if selectProductType == .Kettlebell{
                        kettleBell_Max()
                    } else if selectProductType == .Treadmill{
                        treadMill_Max()
                    }
                }
                
               
                
                
                
                
            }
        }
    }
    
    struct AnimatedButtonStyle: ButtonStyle {
        func makeBody(configuration: Configuration) -> some View {
            configuration.label
                .foregroundColor(configuration.isPressed ? .black : .primary)
                .background(configuration.isPressed ? Color.black : Color.yellow)
                .cornerRadius(10)
                .overlay(
                    RoundedRectangle(cornerRadius: 10)
                        .strokeBorder(Color.black.opacity(0.2), lineWidth: 2)
                )
                .scaleEffect(configuration.isPressed ? 0.95 : 1.0)
                
                
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
            .frame(height: 700)
            .padding(.bottom, 5)
        }
        
        @ViewBuilder
        func Max_Prices() -> some View{
            
            ScrollView {
                LazyVGrid(columns: [GridItem(.adaptive(minimum: 150))], spacing: 20) {
                    ForEach(filteredModels.filter { model in
                        if let modelPrice = Double(model.price ?? ""), modelPrice > 80 {
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
                        if let modelPrice = Double(model.price ?? ""), modelPrice > 80 {
                            return true
                        }
                        return false
                    }
                }
            }
            .background(Color("C_Bg"))
            .frame(height: 800)
            .padding(.bottom, 5)
        }
    @ViewBuilder
    func abdominalWeel_Min() -> some View {
        
            ScrollView {
                LazyVGrid(columns: [GridItem(.adaptive(minimum: 150))], spacing: 20) {
                    ForEach(filteredModels.filter { model in
                        if model.type == "abdominalWheel", let modelPrice = Double(model.price ?? ""), modelPrice < 50 {
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
                                
                                Text("$\(model.price ?? "")")
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
                        model.type == "abdominalWheel" && (Double(model.price ?? "") ?? 0) < 50
                    }
                }
            }
            .background(Color("C_Bg"))
            .padding(.bottom, 5)
    }
        
        @ViewBuilder
        func abdominalWeel_Max() -> some View{
                    ScrollView {
                        LazyVGrid(columns: [GridItem(.adaptive(minimum: 150))], spacing: 20) {
                            ForEach(filteredModels.filter { model in
                                if model.type == "abdominalWheel", let modelPrice = Double(model.price ?? ""), modelPrice > 80 {
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
                                        
                                        Text("$\(model.price ?? "")")
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
                                model.type == "dumbbell" && (Double(model.price ?? "") ?? 0) > 80
                            }
                        }
                    }
                    .background(Color("C_Bg"))
                    .padding(.bottom, 5)
        }
        
        @ViewBuilder
        func Indoor_Min() -> some View{
            ScrollView {
                LazyVGrid(columns: [GridItem(.adaptive(minimum: 150))], spacing: 20) {
                    ForEach(filteredModels) { model in
                        if model.type == "indoorPull-upBar" , let modelPrice = Double(model.price ?? ""), modelPrice < 50 {
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
            .frame(height: 800)
            .padding([.horizontal, .bottom],5)
        }
        
        @ViewBuilder
        func Indoor_Max() -> some View{
            ScrollView {
                LazyVGrid(columns: [GridItem(.adaptive(minimum: 150))], spacing: 20) {
                    ForEach(filteredModels) { model in
                        if model.type == "indoorPull-upBar" , let modelPrice = Double(model.price ?? ""), modelPrice > 80 {
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
            .frame(height: 800)
            .padding([.horizontal, .bottom],5)
        }
        
        @ViewBuilder
        func Dummbell_Min() -> some View{
            ScrollView {
                LazyVGrid(columns: [GridItem(.adaptive(minimum: 150))], spacing: 20) {
                    ForEach(filteredModels) { model in
                        if model.type == "dumbbell", let modelPrice = Double(model.price ?? ""), modelPrice < 50 {
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
            .frame(height: 800)
            .padding([.horizontal, .bottom],5)
        }
        
        @ViewBuilder
        func Dummbell_Max() -> some View{
            
            ScrollView {
                    LazyVGrid(columns: [GridItem(.adaptive(minimum: 150))], spacing: 20) {
                        ForEach(filteredModels.filter { model in
                            if model.type == "dumbbell", let modelPrice = Double(model.price ?? ""), modelPrice > 80 {
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
                                    
                                    Text("$\(model.price ?? "")")
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
                            model.type == "fitnessBoard" && (Double(model.price ?? "") ?? 0) > 80
                        }
                    }
                }
                .background(Color("C_Bg"))
                .frame(height: 800)
                .padding(.bottom, 5)
        }
        
        @ViewBuilder
        func elasticBand_Min() -> some View{
            ScrollView {
                LazyVGrid(columns: [GridItem(.adaptive(minimum: 150))], spacing: 20) {
                    ForEach(filteredModels) { model in
                        if model.type == "elasticBand", let modelPrice = Double(model.price ?? ""), modelPrice < 50 {
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
            .frame(height: 800)
            .padding([.horizontal, .bottom],5)
        }
        
        @ViewBuilder
        func elasticBand_Max() -> some View{
            ScrollView {
                LazyVGrid(columns: [GridItem(.adaptive(minimum: 150))], spacing: 20) {
                    ForEach(filteredModels) { model in
                        if model.type == "elasticBand", let modelPrice = Double(model.price ?? ""), modelPrice > 80 {
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
            .frame(height: 800)
            .padding([.horizontal, .bottom],5)
        }
        
        @ViewBuilder
        func exerciseBike_Min() -> some View{
            ScrollView {
                LazyVGrid(columns: [GridItem(.adaptive(minimum: 150))], spacing: 20) {
                    ForEach(filteredModels) { model in
                        if model.type == "exerciseBike", let modelPrice = Double(model.price ?? ""), modelPrice < 50{
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
            .frame(height: 800)
            .padding([.horizontal, .bottom],5)
        }
        
        @ViewBuilder
        func exerciseBike_Max() -> some View{
            ScrollView {
                LazyVGrid(columns: [GridItem(.adaptive(minimum: 150))], spacing: 20) {
                    ForEach(filteredModels) { model in
                        if model.type == "exerciseBike", let modelPrice = Double(model.price ?? ""), modelPrice > 80{
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
            .frame(height: 800)
            .padding([.horizontal, .bottom],5)
        }
        
        @ViewBuilder
        func exercissMat_Min() -> some View{
            ScrollView {
                LazyVGrid(columns: [GridItem(.adaptive(minimum: 150))], spacing: 20) {
                    ForEach(filteredModels) { model in
                        if model.type == "exercissMat", let modelPrice = Double(model.price ?? ""), modelPrice < 50{
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
            .frame(height: 800)
            .padding([.horizontal, .bottom],5)
        }
        
        @ViewBuilder
        func exercissMat_Max() -> some View{
            ScrollView {
                LazyVGrid(columns: [GridItem(.adaptive(minimum: 150))], spacing: 20) {
                    ForEach(filteredModels) { model in
                        if model.type == "exercissMat", let modelPrice = Double(model.price ?? ""), modelPrice > 80{
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
            .frame(height: 800)
            .padding([.horizontal, .bottom],5)
        }
        
        @ViewBuilder
        func fitnessBoard_Min() -> some View{
            ScrollView {
                LazyVGrid(columns: [GridItem(.adaptive(minimum: 150))], spacing: 20) {
                    ForEach(filteredModels) { model in
                        if model.type == "fitnessBoard" , let modelPrice = Double(model.price ?? ""), modelPrice < 50{
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
            .frame(height: 800)
            .padding([.horizontal, .bottom],5)
        }
        
        @ViewBuilder
        func fitnessBoard_Max() -> some View{
            ScrollView {
                LazyVGrid(columns: [GridItem(.adaptive(minimum: 150))], spacing: 20) {
                    ForEach(filteredModels) { model in
                        if model.type == "fitnessBoard" , let modelPrice = Double(model.price ?? ""), modelPrice > 80{
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
            .frame(height: 800)
            .padding([.horizontal, .bottom],5)
        }
        
        @ViewBuilder
        func jumpRope_Min() -> some View{
            ScrollView {
                LazyVGrid(columns: [GridItem(.adaptive(minimum: 150))], spacing: 20) {
                    ForEach(filteredModels) { model in
                        if model.type == "jumpRope", let modelPrice = Double(model.price ?? ""), modelPrice < 50{
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
            .frame(height: 800)
            .padding([.horizontal, .bottom],5)
        }
        
        @ViewBuilder
        func jumpRope_Max() -> some View{
            ScrollView {
                LazyVGrid(columns: [GridItem(.adaptive(minimum: 150))], spacing: 20) {
                    ForEach(filteredModels) { model in
                        if model.type == "jumpRope", let modelPrice = Double(model.price ?? ""), modelPrice > 80{
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
            .frame(height: 800)
            .padding([.horizontal, .bottom],5)
        }
        
        @ViewBuilder
        func kettleBell_Min() -> some View{
            ScrollView {
                LazyVGrid(columns: [GridItem(.adaptive(minimum: 150))], spacing: 20) {
                    ForEach(filteredModels) { model in
                        if model.type == "kettleBell", let modelPrice = Double(model.price ?? ""), modelPrice < 50{
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
            .frame(height: 800)
            .padding([.horizontal, .bottom],5)
        }
        
        @ViewBuilder
        func kettleBell_Max() -> some View{
            ScrollView {
                LazyVGrid(columns: [GridItem(.adaptive(minimum: 150))], spacing: 20) {
                    ForEach(filteredModels) { model in
                        if model.type == "kettleBell", let modelPrice = Double(model.price ?? ""), modelPrice > 80{
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
            .frame(height: 800)
            .padding([.horizontal, .bottom],5)
        }
        
        @ViewBuilder
        func treadMill_Min() -> some View{
            ScrollView {
                LazyVGrid(columns: [GridItem(.adaptive(minimum: 150))], spacing: 20) {
                    ForEach(filteredModels) { model in
                        if model.type == "treadMill", let modelPrice = Double(model.price ?? ""), modelPrice < 50{
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
            .frame(height: 800)
            .padding([.horizontal, .bottom],5)
        }
        
        @ViewBuilder
        func treadMill_Max() -> some View{
            ScrollView {
                LazyVGrid(columns: [GridItem(.adaptive(minimum: 150))], spacing: 20) {
                    ForEach(filteredModels) { model in
                        if model.type == "treadMill", let modelPrice = Double(model.price ?? ""), modelPrice > 80{
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
            .frame(height: 800)
            .padding([.horizontal, .bottom],5)
        }
}

#Preview {
    ListView()
}
