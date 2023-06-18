//
//  HomeProtocol.swift
//  VideoOnThemand
//
//  Created by Michele Manniello on 20/05/23.
//

import Foundation
import FirebaseFirestore

protocol HomeProtocol {
    func getFilmListener(firestore:Firestore, stream: inout ListenerRegistration? ,localUser:String, listener: @escaping (QuerySnapshot?,Error?) -> Void)
    func getUserListener(firestore:Firestore,email: String, password:String,id: String ,listener: @escaping (QuerySnapshot?,Error?) -> Void)
}

extension HomeProtocol {
    
    func getFilmListener(firestore:Firestore, stream: inout ListenerRegistration?, localUser:String, listener: @escaping (QuerySnapshot?,Error?) -> Void) {
        stream = firestore.collection("Film").whereField("idUtente", isEqualTo: localUser).addSnapshotListener(listener)
    }
    
    func getUserListener(firestore:Firestore,email: String, password:String,id: String ,listener: @escaping (QuerySnapshot?,Error?) -> Void) {
        
        firestore.collection("Utenti").whereField("email", isEqualTo: email).whereField("password",isEqualTo: password).getDocuments(completion: listener)
    }
    
}
