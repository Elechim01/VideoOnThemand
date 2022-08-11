//
//  FilmThumbnail.swift
//  VideoOnThemand
//
//  Created by Michele Manniello on 11/08/22.
//

import SwiftUI

struct FilmThumbnailView: View {
    @EnvironmentObject var homeviewModel: HomeViewModel
    @Environment(\.isFocused) var isFocused
    @Binding var film : Film
    @State var selection: String? = nil
    @FocusState var focusf : Bool
    
    var body: some View {
        
        VStack{
            
            NavigationLink(destination: VideoPlayerView(film: film)
                .environmentObject(homeviewModel)) {
                    
                    film.thmbnail
                        .resizable()
                        .frame(width: 200, height: 200)
                        .onLongPressGesture {
                            selection = film.id
                        }
                }
                .buttonStyle(CardButtonStyle())
            
            Text(film.nome)
                .frame(width: 200)
                .font(.headline)
                .padding()
        }
        
    }
}

struct FilmThumbnail_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
            .environmentObject(LoginViewModel())
            .environmentObject(HomeViewModel())
    }
}
