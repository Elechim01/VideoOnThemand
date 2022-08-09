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
// TODO:  Implementare lo APPSTORAGE
    @Published var showError : Bool = false
    @Published var errorMessage : String = ""
 
    
    func isValidEmail(_ email: String) -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"

        let emailPred = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailPred.evaluate(with: email)
    }
    
    func isValidPassword(testStr:String?) -> Bool {
        guard testStr != nil else { return false }

        // almeno una maiuscola,
        // almeno una cifra
        // almeno una minuscola
        // 8 caratteri in totale
        
        let passwordTest = NSPredicate(format: "SELF MATCHES %@", "(?=.*[A-Z])(?=.*[0-9])(?=.*[a-z]).{8,}")
        return passwordTest.evaluate(with: testStr)
    }
    
//    Page: 0 -> Login, 1 -> Home
    
//     Funzioni di login e logout 
    func login(email: String, password: String){
        if(!Extensions.isConnectedToInternet()){
            errorMessage = "Impossibile effettuare il login in assenza di connessione internet"
            return
        }
        Auth.auth().signIn(withEmail: email, password: password){authResult,error in

            if let err = error{
                print(err.localizedDescription)
                self.errorMessage = err.localizedDescription
                self.showError = true
                return
            }else{
                guard let authResult = authResult else { return }
                print(authResult.user.uid)
                self.page = 1
                return
            }
        }
   
    }
    func logOut(){
        let firebaseAuth = Auth.auth()
        do {
            try firebaseAuth.signOut()
            page = 0
        } catch let singoutError as NSError {
            print("Error %@",singoutError)
        }
    }
}


