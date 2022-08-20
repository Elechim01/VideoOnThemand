//
//  HomeView.swift
//  VideoOnThemand
//
//  Created by Michele Manniello on 09/08/22.
//

import SwiftUI
import AVKit


struct HomeView: View {
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
                    Color("Green").ignoresSafeArea()
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
                    }else{
                        SettingsView(showAlert: $showAlert)
                    }
                    
                    Spacer()
                }
                Spacer()
            }
        }
            .onAppear{
                if homeviewModel.localUser.isEmply{
                    homeviewModel.recuperoUtente(email: homeviewModel.email, password: homeviewModel.password, id: homeviewModel.idUser) {
                        self.showProgressView = true
                        homeviewModel.recuperoFilm(endidng: {
                            self.showProgressView = false
                        })
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
                    loginViewModel.logOut()
                    showAlert.toggle()
                    
                }
            }
        
    }
    @ViewBuilder
    func someSpace()->some View{
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
    
   
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
            .environmentObject(LoginViewModel())
            .environmentObject(HomeViewModel())
    }
}

