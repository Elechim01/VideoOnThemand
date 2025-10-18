//
//  VideoPlayerView.swift
//  VideoOnThemand
//
//  Created by Michele Manniello on 11/08/22.
//

import SwiftUI
import AVKit
import Combine

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
                
                // Aggiorna la cronologia in background
                homeviewModel.updateData(selectedFilm: film)
                print("onAppear: player.currentItem:", playerManager.player.currentItem != nil)

                // Riproduci quando pronto
                playerManager.playWhenReady()
             
//                Chiusura  automatica
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


final class PlayerManager: ObservableObject {
    @Published var player = AVPlayer()
    @Published var errorPlayer: Bool = false
    private var cancellables = Set<AnyCancellable>()
    
    func replaceItem(with item: AVPlayerItem) {
        player.replaceCurrentItem(with: item)
    }
    
    func playWhenReady() {
        guard let currentItem = player.currentItem else { return }
        currentItem.publisher(for: \.status)
            .sink { [weak self] status in
                guard let self = self else { return }
                switch status {
                case .readyToPlay:
                    self.player.play()
                case .failed:
                    errorPlayer.toggle()
                default:
                    break
                }
            }
            .store(in: &cancellables)
    }

    
    
    func stop() {
        player.pause()
        player.replaceCurrentItem(with: nil)
    }
    
}



struct VideoPlayerView_Previews: PreviewProvider {
    static var previews: some View {
        VideoPlayerView(film: Film())
    }
}
