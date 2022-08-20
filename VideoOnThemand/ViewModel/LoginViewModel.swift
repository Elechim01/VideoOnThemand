//
//  LoginViewModel.swift
//  VideoOnThemand
//
//  Created by Michele Manniello on 09/08/22.
//

import UIKit
import SwiftUI
import Firebase

class LoginViewModel: ObservableObject{
 
    @AppStorage("Pagina") var page : Int = 0
    @Published var showError : Bool = false
    @Published var errorMessage : String = ""
 
    //    Memorizzo la password e l'email
    @AppStorage("Password") var password = ""
    @AppStorage("Email") var email = ""
    @AppStorage("IDUser") var idUser = ""
    
   
    
//    Page: 0 -> Login, 1 -> Home
    
//     Funzioni di login e logout 
    func login(email: String, password: String,completition: @escaping (String)->()){
        if(!Extensions.isConnectedToInternet()){
            errorMessage = "Impossibile effettuare il login in assenza di connessione internet"
            return
        }
        Auth.auth().signIn(withEmail: email, password: password){authResult,error in

            if let err = error{
                print(err.localizedDescription)
                self.errorMessage = err.localizedDescription
                self.showError = true
                completition("")
                return
            }else{
                guard let authResult = authResult else { return }
                print(authResult.user.uid)
                self.password = password
                self.email = email
                self.idUser = authResult.user.uid
               completition(authResult.user.uid)
                return
            }
        }
    }
    
    func logOut(){
        let firebaseAuth = Auth.auth()
        do {
            try firebaseAuth.signOut()
            self.email = ""
            self.password = ""
            self.idUser = ""
            page = 0
        } catch let singoutError as NSError {
            print("Error %@",singoutError)
        }
    }
}


