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
                    if(film.thumbnail.isEmpty){
                        Image("backgroundImage")
                            .resizable()
                            .frame(width: 200, height: 200)
                            .onLongPressGesture {
                                selection = film.id
                            }
                        
                    }else{
                        AsyncImage(url: URL(string: film.thumbnail) ?? URL(string: "")) { image  in
                            image
                                .resizable()
                        } placeholder: {
                            
                        }
                        .frame(width: 200, height: 200)
                        .onLongPressGesture {
                            selection = film.id
                        }
                    }
                }
                .buttonStyle(CardButtonStyle())
            
            Text(film.nome)
                .frame(width: 200)
                .font(.caption)
                .padding()
        }
        
    }
}

struct FilmThumbnail_Previews: PreviewProvider {
    static var previews: some View {
        FilmThumbnailView(film: .constant(Film()))
            .environmentObject(HomeViewModel())
    }
}
