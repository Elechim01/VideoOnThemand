//
//  VideoPlayerView.swift
//  VideoOnThemand
//
//  Created by Michele Manniello on 11/08/22.
//

import SwiftUI
import AVKit
import Combine
import Services

struct VideoPlayerView: View {
    @StateObject private var playerManager = PlayerManager()
    var film: Film
    @EnvironmentObject var homeviewModel: HomeViewModel
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        VideoPlayer(player: playerManager.player)
            .ignoresSafeArea(.all,edges: .all)
            .onAppear {
                guard let url = URL(string: film.url) else { return }
                
                let playerItem = AVPlayerItem(url: url)
                playerItem.externalMetadata = homeviewModel.createMetadata(title: film.nome)
                
                playerManager.replaceItem(with: playerItem)
                
                Task {
                    await homeviewModel.updateData(selectedFilm: film)
                }
                print("onAppear: player.currentItem:", playerManager.player.currentItem != nil)
                
                // Riproduci quando pronto
                playerManager.playWhenReady()
                
                
                NotificationCenter.default.addObserver(
                    forName: AVPlayerItem.didPlayToEndTimeNotification,
                    object: playerItem, queue: .main) { _ in
                        dismiss()
                    }
            }
            .onDisappear {
                playerManager.stop()
            }
            .alert("Errore nel caricamento del video", isPresented: $playerManager.errorPlayer, actions: {
                Button {
                    playerManager.errorPlayer.toggle()
                    dismiss()
                } label: {
                    Text("Chiudi")
                }
            })
    }
}

struct VideoPlayerView_Previews: PreviewProvider {
    static var previews: some View {
        VideoPlayerView(film: Film())
    }
}

