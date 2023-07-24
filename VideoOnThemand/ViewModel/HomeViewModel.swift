//
//  HomeViewModel.swift
//  VideoOnThemand
//
//  Created by Michele Manniello on 09/08/22.
//

import UIKit
import SwiftUI
import Firebase
import FirebaseStorage
import FirebaseFirestore
import AVKit

class HomeViewModel: ObservableObject, HomeProtocol {
    
//     Recupero film e altro
    @Published var films : [Film] = []
    @Published var localUser : Utente = Utente()
//    Memorizzo la password, l'email e l'id
    @AppStorage("Password") var password = ""
    @AppStorage("Email") var email = ""
    @AppStorage("IDUser") var idUser = ""
    @AppStorage("ShowGrid") var storageGrid = false
    @AppStorage("Order") var storageAscendindOrder = false
    
//    MARK: Alert
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
            self.films =  self.films.sorted(by:{ $0.nome.compare($1.nome,options: .caseInsensitive) ==  (self.orderAscending ? .orderedAscending : .orderedDescending) })
             storageAscendindOrder = orderAscending
        }
    }
    
    public var totalSizeFilm: Double {
        var size = 0.0
        films.forEach { size += $0.size }
        return size
    }
    
    public let totalSize = 5000.0
    
    let firestore : Firestore
    let firebaseStorage: Storage
    var stream: ListenerRegistration?
    
    init(){
        firestore = Firestore.firestore()
        firebaseStorage = Storage.storage()
        showGrid = storageGrid
        orderAscending = storageAscendindOrder
    }
    
    internal func recuperoFilm(endidng:@escaping ()->()){
        //     MARK: For test
        getFilmListener(firestore: firestore,stream: &stream ,localUser: localUser.id) { [weak self]
            querySnapshot, error in
            guard let self = self else { return }
            if let erro = error{
                self.alertMessage = erro.localizedDescription
                self.showAlert.toggle()
                endidng()
                return
            }
            else{
                self.films.removeAll()
                for document in querySnapshot!.documents{
                    let data = document.data()
                    if let film = Film.getFilm(json: data) {
                        self.films.append(film)
                    }
                }
            }
            print(self.films)
            self.films =  self.films.sorted(by:{ $0.nome.compare($1.nome,options: .caseInsensitive) ==  (self.orderAscending ? .orderedAscending : .orderedDescending) })
            endidng()
        }
    }
    
    internal func recuperoThumbnail(c: Int = 0) {
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
    
    internal func recuperoUtente(email: String, password:String,id: String,ending: (()->())?){
        getUserListener(firestore: firestore, email: email, password: password, id: id) { [weak self] querySnapshot, err  in
            guard let self = self else { return }
            if let err = err {
                self.alertMessage = err.localizedDescription
                self.showAlert.toggle()
               ending?()
                
            }else{
                if(querySnapshot!.documents.count > 1){
                    self.alertMessage = "Errore nel DB presente più utenti"
                    self.showAlert.toggle()
                    ending?()
                }else{
                    if(querySnapshot!.documents.first == nil){
                        return
                    }
                    let data = querySnapshot!.documents.first!.data()
                    if let user = Utente.getUser(json: data) {
                        self.localUser = user
                    }
//                    per la pagina
                    ending?()
                }
                print(self.localUser)
            }
        }
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

