//
//  PlayerManager.swift
//  VideoOnThemand
//
//  Created by Michele Manniello on 02/04/26.
//

import Foundation
import SwiftUI
import AVKit
import Combine

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
