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
                        
                        Text("I tuoi video:")
                            .font(.headline)
                        ScrollView(.horizontal) {
                            HStack(alignment:.top) {
                                    ForEach($homeviewModel.films){ $film in
                                            FilmThumbnailView(film: $film)
                                            .environmentObject(homeviewModel)
                                    }
                                }
                        }
                    }else{
                        SettingsView(showAlert: $showAlert)
                    }
                    
                    Spacer()
                }
            }
        }
            .onAppear(perform: {
                homeviewModel.recuperoFilm(user: loginViewModel.user)
            })
            .alert(homeviewModel.errorMessage, isPresented: $homeviewModel.alertfirebase, actions: {
                Button("OK",role: .cancel){
                    homeviewModel.alertfirebase.toggle()
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
    
   
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
            .environmentObject(LoginViewModel())
            .environmentObject(HomeViewModel())
    }
}

