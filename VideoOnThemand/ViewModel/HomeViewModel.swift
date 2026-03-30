//
//  HomeViewModel.swift
//  VideoOnThemand
//
//  Created by Michele Manniello on 09/08/22.
//

import UIKit
import SwiftUI
import Firebase
import FirebaseFirestore
import AVKit

class HomeViewModel: ObservableObject {
    
    // Recupero film e altro
    @Published var films : [Film] = []
    @Published var localUser : Utente = Utente()
    // Memorizzo la password, l'email e l'id
    @AppStorage("Password") var password = ""
    @AppStorage("Email") var email = ""
    @AppStorage("IDUser") var idUser = ""
    @AppStorage("ShowGrid") var storageGrid = false
    @AppStorage("Order") var storageAscendindOrder = false
    
    // MARK: Alert
    @Published var showAlert: Bool = false
    @Published var alertMessage : String = ""
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
    
    public let totalSize = 5000.0
    
    let firestore : Firestore
    //let firebaseStorage: Storage
    var stream: ListenerRegistration?
    
    init(){
        firestore =  FirebaseManager.shared.firestore
        // firebaseStorage = FirebaseManager.shared.firebaseStorage
        showGrid = storageGrid
        orderAscending = storageAscendindOrder
    }
    
    
    internal func createMetadata(title: String) -> [AVMetadataItem]{
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
    
    
    
}

extension HomeViewModel: FirebaseProtocol {
    func recuperoFilm(endidng:@escaping () async ->()){
        // MARK: For test
        getFilmListener(firestore: firestore,stream: &stream ,localUser: localUser.id) { [weak self]
            querySnapshot, error in
            guard let self = self else { return }
            if let erro = error{
                self.alertMessage = erro.localizedDescription
                self.showAlert.toggle()
                Task{
                    await endidng()
                }
                
                return
            }
            else{
                self.films.removeAll()
#if DEBUG
                let limit = 20
                var count = 0
                for document in querySnapshot!.documents{
                    guard count != limit else {
                        break
                    }
                    
                    if  let film =  try? document.data(as: Film.self) {
                        self.films.append(film)
                    }
                    count+=1
                }
#else
                for document in querySnapshot!.documents{
                    if  let film =  try? document.data(as: Film.self) {
                        self.films.append(film)
                    }
                }
#endif
            }
#if DEBUG
            self.films.forEach { print("\($0.nome)")  }
#endif
            
            // ----- SORT BY DATE AFTER FETCH -----
            self.films = self.films.sorted {
                let d0 = $0.data ?? Date.now
                let d1 = $1.data ?? Date.now
                return self.orderAscending ? d0 < d1 : d0 > d1
            }
            
            Task{
                await endidng()
            }
        }
    }
    
    /*
    func recuperoThumbnail(c: Int = 0) {
        var count = c
        print(count)
        self.getThumbNail(storage: firebaseStorage, film: films[count]) { [weak self] path in
            guard let self = self else { return }
            films[c].localImage = URL(fileURLWithPath: path)
            count += 1
            if count < self.films.count {
                self.recuperoThumbnail(c: count)
            }
        } failure: { [weak self] error in
            guard let self = self else { return  }
            self.alertMessage = error.localizedDescription
            self.showAlert.toggle()
        }
    }
    */
    
    func recuperoUtente(email: String, password:String,id: String,ending: (() async -> ())?){
        getUserListener(firestore: firestore, email: email, password: password, id: id) { [weak self] querySnapshot, err  in
            guard let self = self else { return }
            if let err = err {
                self.alertMessage = err.localizedDescription
                self.showAlert.toggle()
                Task{
                    await ending?()
                }
                
            }else{
                if(querySnapshot!.documents.count > 1){
                    self.alertMessage = "Errore nel DB presente più utenti"
                    self.showAlert.toggle()
                    Task{
                        await ending?()
                    }
                }else{
                    if(querySnapshot!.documents.first == nil){
                        return
                    }
                    
                    if let user =  try? querySnapshot!.documents.first!.data(as: Utente.self) {
                        self.localUser = user
                    }
                    
                    Task{
                        await ending?()
                    }
                }
                print(self.localUser)
            }
        }
    }
    
    func updateData(selectedFilm: Film) {
        updatePlayDate(firestore: firestore, film: selectedFilm, localUser: localUser.id, onError: { error in
            print("\(error.localizedDescription)")
        })
    }
}
