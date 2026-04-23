//
//  HomeViewModel.swift
//  VideoOnThemand
//
//  Created by Michele Manniello on 09/08/22.
//

import UIKit
import SwiftUI
import AVKit
import ElechimCore
import Services

@MainActor
class HomeViewModel: ObservableObject {
    
    // Recupero film e altro
    @Published var films : [Film] = []
    // Memorizzo la password, l'email e l'id
    @AppStorage("IDUser") var userId = ""
    @AppStorage("ShowGrid") var storageGrid = false
    @AppStorage("Order") var storageAscendindOrder = false
    
    // MARK: Alert
    @Published var showAlert: Bool = false
    @Published var alertMessage : String = ""
    @Published var showProgressView: Bool = false
    @Published var showGrid = false {
        didSet {
            storageGrid = showGrid
            print("storage: \(storageGrid)")
        }
    }
    @Published var orderAscending = false {
        didSet {
            // ----- SORT BY DATE -----
            self.films = self.films.sorted {
                let d0 = $0.data ?? Date.distantPast
                let d1 = $1.data ?? Date.distantPast
                return orderAscending ? d0 < d1 : d0 > d1
            }
            storageAscendindOrder = orderAscending
        }
    }
    @Published var chronologyList: [Chronology] = []
    
    public var totalSizeFilm: Double {
        var size = 0.0
        films.forEach { size += $0.size }
        return size
    }
    
    public let totalSize = 10240.0
    
    private let updateChronologyUseCase: UpdateChronologyUseCase
    private let fetchMovieUseCase: FetchMovieUseCase
    private let getCurrentUserUseCase: GetCurrentUserUseCase
    let sessionManager: SessionManager
    
    init(updateChronologyUseCase: UpdateChronologyUseCase,
         fetchMovieUseCase: FetchMovieUseCase,
         getCurrentUserUseCase: GetCurrentUserUseCase,
         sessionManager: SessionManager){
        self.updateChronologyUseCase = updateChronologyUseCase
        self.fetchMovieUseCase = fetchMovieUseCase
        self.getCurrentUserUseCase = getCurrentUserUseCase
        self.sessionManager = sessionManager
        self.showGrid = storageGrid
        self.orderAscending = storageAscendindOrder
    }
    
    func createMetadata(title: String) -> [AVMetadataItem]{
        let mapping: [AVMetadataIdentifier: Any] = [
            .iTunesMetadataTrackSubTitle : title,
        ]
        return mapping.compactMap{createMetadataItem(for: $0, value: $1)}
    }
    
    private func createMetadataItem(for identifier: AVMetadataIdentifier,value: Any) -> AVMetadataItem {
        let item = AVMutableMetadataItem()
        item.identifier = identifier
        item.value = value as? NSCopying & NSObjectProtocol
        item.extendedLanguageTag = "und"
        return item.copy() as! AVMetadataItem
    }
    
    
    func start() async {
        await recuperoUtente()
        Task {
            await recuperoFilm()
        }
    }
    
    func recuperoFilm() async {
        self.showProgressView = true
        do {
            let stream = await fetchMovieUseCase.execute(localUserId: sessionManager.currentUser?.id ?? "")
            for try await films in stream {
#if DEBUG
                films.forEach { print("\($0.nome)")  }
#endif
#warning("Implementare Comparable")
                self.showProgressView = false
                self.films = films.sorted {
                    let d0 = $0.data ?? Date.now
                    let d1 = $1.data ?? Date.now
                    return self.orderAscending ? d0 < d1 : d0 > d1
                }
            }
            
        } catch  {
            Utils.showError(alertMessage: &alertMessage, showAlert: &showAlert, from: error)
        }
    }
    
    func recuperoUtente() async {
        self.showProgressView = true
        do {
           let user = try await getCurrentUserUseCase.execute(userId: userId)
            self.sessionManager.currentUser = user
            self.showProgressView = false
        } catch  {
            Utils.showError(alertMessage: &alertMessage, showAlert: &showAlert, from: error)
        }
       
    }
  
    func updateData(selectedFilm: Film) async  {
        do {
            try await updateChronologyUseCase.execute(film: selectedFilm,
                                                      localUserId: self.sessionManager.currentUser?.id ?? "")
        } catch {

            Utils.showError(alertMessage: &alertMessage, showAlert: &showAlert, from: error)
        }
    }
    
    
}
