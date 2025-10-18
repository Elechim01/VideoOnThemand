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
                        AsyncImage(url: film.localImage ?? URL(string: film.thumbnail)) { image  in
                            image
                                .resizable()
                        } placeholder: {
                            Color.gray.opacity(0.3)
                        }
                        .frame(width: 300)
                        .aspectRatio(16/9, contentMode: .fit)
                        .onLongPressGesture {
                            selection = film.id
                        }
                        
                    }
                }
                .buttonStyle(CardButtonStyle())
                .glassEffect(.regular, in: .buttonBorder)
                .padding()
                
            
            Text(film.nome)
                .frame(width: 200)
                .font(.caption)
                .padding()
                .glassEffect(.regular, in: .buttonBorder)
            
        }
       
    }
}

struct FilmThumbnail_Previews: PreviewProvider {
    static var previews: some View {
        FilmThumbnailView(film: .constant(Film()))
            .environmentObject(HomeViewModel())
            .background(Color.green)
        
        
    }
}
