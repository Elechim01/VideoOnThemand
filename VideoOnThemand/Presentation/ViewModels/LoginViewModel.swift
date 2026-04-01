//
//  LoginViewModel.swift
//  VideoOnThemand
//
//  Created by Michele Manniello on 09/08/22.
//

import UIKit
import SwiftUI
import ElechimCore

@MainActor
class LoginViewModel: ObservableObject{
 
    @Published var showError : Bool = false
    @Published var errorMessage : String = ""
    @Published var showProgressView: Bool = false
 
    //    Memorizzo la password e l'email
    @AppStorage("IDUser") var idUser = ""
    
    @Published var email: String = ""
    @Published var password: String = ""
    
    private let loginUseCase: LoginUseCase
    private let logoutUseCase: LogoutUseCase
    private let restoreSessionUseCase: RestoreSessionUseCase
    
    var getCheck: Bool {
        if email.isEmpty {
            errorMessage = "Il campo email è vuoto"
            return false
        }
        if !Utils.isValidEmail(email) {
            errorMessage = "L'email non è valida"
            return false
        }
        if password.isEmpty {
           errorMessage = "Il campo password è vuoto"
            return false
        }
        if !Utils.isValidPassword(testStr: password) {
            errorMessage = "La password non è valida, deve comprendere: Almeno una maiuscola, Almeno un numero, Almeno una minuscola, 8 caratteri in totale"
            return false
        }
        return true
    }
    
    init(loginUseCase: LoginUseCase,
         logoutUseCase: LogoutUseCase,
         restoreSessionUseCasse: RestoreSessionUseCase
    ) {
        self.loginUseCase = loginUseCase
        self.logoutUseCase = logoutUseCase
        self.restoreSessionUseCase = restoreSessionUseCasse
    }
    
//    Page: 0 -> Login, 1 -> Home
    
    
    func login() async -> Bool  {
      
        do {
            guard getCheck else {
                self.showError.toggle()
                return false
            }
            guard Utils.isConnectedToInternet() else {
                throw CustomError.connectionError
            }
            showProgressView = true
            let idUser = try await loginUseCase.execute(email: email, password: password)
            self.idUser = idUser
            showProgressView = false
            return true
        } catch  {
            Utils.showError(alertMessage: &errorMessage, showAlert: &showError, from: error)
            return false
        }
    }
    
    func restoreSession() -> Bool {
        do {
            try restoreSessionUseCase.execute()
            return true
        } catch  {
            return false
        }
    }
    
    func logOut() -> Bool{
        do {
            try  logoutUseCase.execute()
            self.idUser = ""
            return true
        } catch {
            Utils.showError(alertMessage: &errorMessage, showAlert: &showError, from: error)
            return false
        }
    }
    
   /* func onLoginTapped() async {
       await coordinator?.login()
    }
    */
}


