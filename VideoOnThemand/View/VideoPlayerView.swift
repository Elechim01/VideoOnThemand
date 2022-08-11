//
//  VideoPlayerView.swift
//  VideoOnThemand
//
//  Created by Michele Manniello on 11/08/22.
//

import SwiftUI
import AVKit

struct VideoPlayerView: View {
    @State var player = AVPlayer()
    var film : Film
    @EnvironmentObject var homeviewModel: HomeViewModel
    
    var body: some View {
        VideoPlayer(player: player)
            .ignoresSafeArea(.all,edges: .all)
            .onAppear {
                
                guard let url = URL(string: film.url) else{return}
                
                let playerItem = AVPlayerItem(url: url)
             
                let result = homeviewModel.createMetadata(title: self.film.nome)
                print(result)
                playerItem.externalMetadata = result
                player = AVPlayer(playerItem: playerItem)
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                    player.play()
                }
            }
            
    }
}

struct VideoPlayerView_Previews: PreviewProvider {
    static var previews: some View {
        VideoPlayerView(film: Film())
    }
}
