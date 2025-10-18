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
        VStack(alignment: .leading) {
            if showProgressView {
                HStack {
                    Spacer()
                    ProgressView()
                        .shadow(color: Color(red: 0, green: 0, blue: 10),
                                radius: 4.0, x: 1.0, y: 2.0)
                    Spacer()
                }
            } else {
                Text("HOME.TITLE".localized())
                    .font(.headline)
                    .foregroundColor(.white)
                
                Group {
                    if !homeviewModel.showGrid {
                        horizontalLayout()
                           
                    } else {
                        gridLayout()
                    }
                }
                .frame(maxWidth: .infinity)
                .padding(.top)
            }
            Spacer()
        }
        .padding(.horizontal)
        .onAppear{
            if isPreviews {
                homeviewModel.films = mockFilms
                loginViewModel.idUser = mockUtente.id
                
            }else {
                self.showProgressView = true
                if homeviewModel.localUser.isEmply{
                    Task {
                        homeviewModel.recuperoUtente(email: homeviewModel.email, password: homeviewModel.password, id: homeviewModel.idUser)   {
                            await MainActor.run {
                                
                                self.showProgressView = true
                            }
                            homeviewModel.recuperoFilm(endidng: {
                                await MainActor.run {
                                    self.showProgressView = false
                                }
                                Task(priority: .background) {
                                    homeviewModel.recuperoThumbnail()
                                }
                            })
                        }
                    }
                } else{
                    self.showProgressView = true
                    print("Fetch film")
                    Task {
                        homeviewModel.recuperoFilm(endidng: {
                            await MainActor.run {
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
        
        
    }
    

   
    @ViewBuilder
    private func horizontalLayout() -> some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(alignment: .center, spacing: 30) {
                ForEach($homeviewModel.films) { $film in
                    FilmThumbnailView(film: $film)
                        .environmentObject(homeviewModel)
                        .frame(maxWidth: .infinity)
                   
                    
                }
            }
            .padding(.horizontal)
            // Spazio extra se pochi film
            .frame(maxWidth: .infinity, alignment: homeviewModel.films.count < 5 ? .leading : .center)
        }
    }
    
    @ViewBuilder
    private func gridLayout() -> some View {
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

#Preview {
    HomeView()
        .environmentObject(LoginViewModel())
        .environmentObject(HomeViewModel())
}

