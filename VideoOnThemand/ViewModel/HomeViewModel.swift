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

class HomeViewModel: ObservableObject{
    
//     Recupero film e altro
    @Published var films : [Film] = []
  
    @Published var localUser : Utente = Utente()
//    Memorizzo la password, l'email e l'id
    @AppStorage("Password") var password = ""
    @AppStorage("Email") var email = ""
    @AppStorage("IDUser") var idUser = ""

//    MARK: Alert
    @Published var showAlert: Bool = false
    @Published var alertMessage : String = ""
    
    let firestore : Firestore
    let firebaseStorage: Storage
    
    init(){
        firestore = Firestore.firestore()
        firebaseStorage = Storage.storage()
    }
    
    func recuperoFilm(endidng:@escaping ()->()){
//        MARK: For test
        firestore.collection("Film").whereField("idUtente", isEqualTo: localUser.id).addSnapshotListener {
            querySnapshot, error in
            if let erro = error{
                self.alertMessage = erro.localizedDescription
                self.showAlert.toggle()
                endidng()
                return
            }
            else{
                self.films.removeAll()
                for document in querySnapshot!.documents{
                    let id = document.documentID
                    let data = document.data()
                    let idUtente: String = data["idUtente"] as? String ?? ""
                    let nomefile = data["nome"] as? String ?? ""
                    let url :String = data["url"] as? String ?? ""
                    let thumbanil : String = data["thumbnail"] as? String ?? ""

                    self.films.append(Film(id: id, idUtente: idUtente, nome: nomefile, url: url, thmbnail: thumbanil))
                }
            }
                print(self.films)
                self.films =  self.films.sorted(by:{ $0.nome.compare($1.nome,options: .caseInsensitive) == .orderedAscending })
            endidng()
        }
        

    }
    
    func recuperoUtente(email: String, password:String,id: String,ending: (()->())?){
        
        firestore.collection("Utenti").whereField("email", isEqualTo: email).whereField("password",isEqualTo: password).getDocuments { querySnapshot, err  in
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
                    let nome : String = data["nome"] as? String ?? ""
                    let cognome: String = data["cognome"] as? String ?? ""
                    let eta: Int = data["eta"] as? Int ?? 0
                    let email: String = data["email"] as? String ?? ""
                    let password: String = data["password"] as? String ?? ""
                    let cellulare: String = data["cellulare"] as? String ?? ""
                    self.localUser = Utente(id: id, nome: nome, cognome: cognome, età: eta, email: email, password: password, cellulare: cellulare)
//                    per la pagina
                    ending?()
                }
                print(self.localUser)
            }
        }
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
    
}
