//
//  HomeView.swift
//  VideoOnThemand
//
//  Created by Michele Manniello on 09/08/22.
//

import SwiftUI
import AVKit


struct HomeView: View {
    
    @Environment(\.isPreview) var isPreviews
    
    @State var showAlert: Bool = false
    @State private var page = 0
    @EnvironmentObject var loginViewModel: LoginViewModel
    @EnvironmentObject var homeviewModel: HomeViewModel
    @FocusState private var usernameFieldIsFocused: Bool
    @State var showProgressView: Bool = false
    
    var body: some View {
        NavigationView{
            ZStack {
                if(page == 0){
                    Color("Green")
                        .ignoresSafeArea()
                }else{
                    Color.gray.opacity(0.5).ignoresSafeArea()
                }
                VStack(alignment: .leading){
                    HStack {
                        Spacer()
                        Picker("Page", selection: $page) {
                            Text("Video").tag(0)
                            Text("Impostazioni").tag(1)
                        }
                        .background(Color.black)
                        .frame(maxWidth: 600)
                        .clipShape(Capsule())
                        Spacer()
                    }
                    
                    if(page == 0){
                        
                        Spacer()
                        Spacer()
                        
                        if(showProgressView){
                            HStack {
                                Spacer()
                              
                            ProgressView()
                                    .shadow(color: Color(red: 0, green: 0, blue: 0.6),
                                                        radius: 4.0, x: 1.0, y: 2.0)
                                Spacer()
                            }
                        }else{
                        Text("I tuoi video:")
                            .font(.headline)
                            .foregroundColor(.black)
                            if !homeviewModel.showGrid {
                                horizontalLayout()
                            }else {
                                girdLayout()
                            }
                        }
                    }
                    else {
                        SettingsView(showAlert: $showAlert)
                        .environmentObject(homeviewModel)
                    }
                    Spacer()
                }
                Spacer()
            }
        }
            .onAppear{
                UIApplication.shared.windows.first?.snapshotView(afterScreenUpdates: true)
                if isPreviews {
                    homeviewModel.films = mockFilms
                    loginViewModel.idUser = mockUtente.id
                    
                }else {
                    if homeviewModel.localUser.isEmply{
                        Task {
                            homeviewModel.recuperoUtente(email: homeviewModel.email, password: homeviewModel.password, id: homeviewModel.idUser) {
                                DispatchQueue.main.async {
                                    self.showProgressView = true
                                }
                                homeviewModel.recuperoFilm(endidng: {
                                    DispatchQueue.main.async {
                                        self.showProgressView = false
                                    }
                                })
                            }
                        }
                    } else{
                        self.showProgressView = true
                        Task {
                            homeviewModel.recuperoFilm(endidng: {
                                DispatchQueue.main.async {
                                    self.showProgressView = false
                                }
                               
                            })
                        }
                    }
                }
            }
            .alert(homeviewModel.alertMessage, isPresented: $homeviewModel.showAlert, actions: {
                Button("OK",role: .cancel){
                    homeviewModel.showAlert.toggle()
                }
            })
            .alert("Sei Sicuro di voler effettuare il Logout?", isPresented: $showAlert) {
                Button("Annulla",role: .cancel){
                    showAlert = false
                }
                
                Button("Conferma",role: .destructive){
                    homeviewModel.stream?.remove()
                    loginViewModel.logOut()
                    showAlert.toggle()
//                    UIApplication.shared.windows.first?.snapshotView(afterScreenUpdates: true)
                    
                }
            }
        
    }
    
    @ViewBuilder
    private func someSpace() -> some View{
        if(homeviewModel.films.count == 1){
            ForEach(1...10,id:\.self) {_ in
                Spacer()
            }
        }
        if(homeviewModel.films.count > 1 && homeviewModel.films.count == 4){
            ForEach(1...5,id:\.self) {_ in
                Spacer()
            }
        }
       
    }
   
    @ViewBuilder
    private func horizontalLayout() -> some View {
        HStack(alignment: .center) {
            someSpace()
            ScrollView(.horizontal) {
                    HStack(spacing: 30) {
                       
                            ForEach($homeviewModel.films){ $film in
                                    FilmThumbnailView(film: $film)
                                    .environmentObject(homeviewModel)
                                    .frame(maxWidth: .infinity)
                            }
                        }
                    
                }
            .frame(alignment: .center)
        }
    }
    
    @ViewBuilder
    private func girdLayout() -> some View {
        let columns = Array(repeating: GridItem(.flexible()), count: 5)
        
        ScrollView {
            LazyVGrid(columns: columns,spacing: 20) {
                ForEach($homeviewModel.films){ $film in
                        FilmThumbnailView(film: $film)
                        .environmentObject(homeviewModel)
                        .frame(maxWidth: .infinity)
                }
            }
            .padding(.horizontal)
        }
    }
}



struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
            .environmentObject(LoginViewModel())
            .environmentObject(HomeViewModel())
    }
}

