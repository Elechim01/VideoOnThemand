//
//  HomeProtocol.swift
//  VideoOnThemand
//
//  Created by Michele Manniello on 20/05/23.
//

import Foundation
import FirebaseFirestore
import FirebaseStorage

protocol HomeProtocol {
    func getFilmListener(firestore:Firestore, stream: inout ListenerRegistration? ,localUser:String, listener: @escaping (QuerySnapshot?,Error?) -> Void)
    func getUserListener(firestore:Firestore,email: String, password:String,id: String ,listener: @escaping (QuerySnapshot?,Error?) -> Void)
    func getThumbNail(storage:Storage,film: Film ,succes: @escaping (String) -> Void, failure: @escaping(Error) -> Void)
}

extension HomeProtocol {
    
    func getFilmListener(firestore:Firestore, stream: inout ListenerRegistration?, localUser:String, listener: @escaping (QuerySnapshot?,Error?) -> Void) {
        stream = firestore.collection("Film").whereField("idUtente", isEqualTo: localUser).addSnapshotListener(listener)
    }
    
    func getUserListener(firestore:Firestore,email: String, password:String,id: String ,listener: @escaping (QuerySnapshot?,Error?) -> Void) {
        
        firestore.collection("Utenti").whereField("email", isEqualTo: email).whereField("password",isEqualTo: password).getDocuments(completion: listener)
    }
    
    func getThumbNail(storage:Storage, film: Film, succes: @escaping (String) -> Void, failure: @escaping(Error) -> Void) {
        
        let localPathReference = Extensions.getDocumentsDirectory().appendingPathComponent("thumbnail/\(film.nome.split { $0 == "." }[0]).png")
        let localPathString = Extensions.getDocumentsDirectory().path() + "/thumbnail"
        
        do {
            try FileManager.default.createDirectory(atPath: localPathString, withIntermediateDirectories: true,attributes: nil)
            print(localPathReference)
            let httpsReference = storage.reference(forURL: film.thumbnail)
            httpsReference.write(toFile: localPathReference) { url, error in
                if let error {
                    print("!Error to fetch")
                    failure(error)
                } else {
                    print("!Success")
                    print("File PNG creato con successo.")
                    if let url {
                        succes(url.path())
                    }else {
                        failure(CustomError.genericError)
                    }
                   
                }
            }
        } catch  {
            print(error)
        }
    }
}
