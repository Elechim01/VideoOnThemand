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

class HomeViewModel: ObservableObject{
    
//     Recupero film e altro
    @Published var films : [Film] = []
    @Published var alertfirebase: Bool = false
    @Published var errorMessage : String = ""
    
    
    func recuperoFilm(user: Utente){
        let db = Firestore.firestore()
//        MARK: For test
//        db.collection("Film").whereField("idUtente", isEqualTo: user.id).addSnapshotListener {
            db.collection("Film").addSnapshotListener {
            querySnapshot, error in
            if let erro = error{
                self.errorMessage = erro.localizedDescription
                self.alertfirebase.toggle()
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
                    let thumbanil : Image = data["thumbnail"] as? Image ?? Image("backgroundImage")

                    self.films.append(Film(id: id, idUtente: idUtente, nome: nomefile, url: url, thmbnail: thumbanil))
                }
            }
                self.films =  self.films.sorted(by:{ $0.nome.compare($1.nome,options: .caseInsensitive) == .orderedAscending })
        }

    }
    
}