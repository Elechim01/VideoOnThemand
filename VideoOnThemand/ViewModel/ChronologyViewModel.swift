//
//  ChronologyViewModel.swift
//  VideoOnThemand
//
//  Created by Michele Manniello on 26/08/25.
//

import Foundation
import Firebase
import FirebaseFirestore

class ChronologyViewModel: ObservableObject, FirebaseProtocol {
    @Published var chronologyList: [Chronology] = []
    @Published var showAlert: Bool = false
    @Published var alertMessage : String = ""
    private let firestore : Firestore
    private var chronologyStream: ListenerRegistration?
    var localUser : Utente
    
    
    init(localUser: Utente) {
        firestore = FirebaseManager.shared.firestore
        self.localUser = localUser
    }
    
    func listenerChronology() {
        getChronologyListener(firestore: firestore, localUser: localUser.id, stream: &chronologyStream) { [weak self] querySnapshot, error in
            guard let self = self else { return }
            if let erro = error{
                self.alertMessage = erro.localizedDescription
                self.showAlert.toggle()
                return
            } else {
                var listChronology: [Chronology] = []
                
                for document in querySnapshot!.documents{
                    let data = document.data()
                    if let chronology = Chronology.getChronology(json: data) {
                        listChronology.append(chronology)
                    }
                    
                }
                
                chronologyList = listChronology.sorted(by: { $0.date > $1.date })
            }
        }
    }
}
