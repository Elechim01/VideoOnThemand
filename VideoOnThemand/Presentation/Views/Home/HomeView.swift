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
    @EnvironmentObject var homeviewModel: HomeViewModel
    @FocusState private var usernameFieldIsFocused: Bool
    
    var body: some View {
        ZStack {
            VStack(alignment: .leading) {
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
                
                Spacer()
            }
            .padding(.horizontal)
            if homeviewModel.showProgressView {
                CustomProgressView()
            }
        }
        .onAppear(perform: {
            if isPreviews {
                homeviewModel.films = mockFilms
                homeviewModel.showProgressView = true
            }
        })
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
        .environmentObject(Coordinator().homeViewModel)
}

