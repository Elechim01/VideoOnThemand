//
//  LoginViewModel.swift
//  VideoOnThemand
//
//  Created by Michele Manniello on 09/08/22.
//

import UIKit
import SwiftUI
import ElechimCore
import FirebaseCrashlytics

@MainActor
class LoginViewModel: ObservableObject{
    
    @Published var showError : Bool = false
    @Published var errorMessage : String = ""
    @Published var showProgressView: Bool = false
    @Published var canShowAutoFill: Bool = false
    
    //    Memorizzo la password e l'email
    @AppStorage("IDUser") var idUser = ""
    
    @Published var email: String = ""
    @Published var password: String = ""
    
    private let loginUseCase: LoginUseCase
    private let logoutUseCase: LogoutUseCase
    private let restoreSessionUseCase: RestoreSessionUseCase
    private let getRememberedCredentialUseCase: GetRememberedCredentialsUseCase
    private let deleteRememberedCredentialUseCase: DeleteRememberedCredentialsUseCase
    private let existRememberedCredentialUseCase: ExistRememberedCredentialUseCase
    
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
         restoreSessionUseCasse: RestoreSessionUseCase,
         getRememberedCredentialUseCase: GetRememberedCredentialsUseCase,
         deleteRememberedCredentialUseCase: DeleteRememberedCredentialsUseCase,
         existRememberedCredentialUseCase: ExistRememberedCredentialUseCase,
    ) {
        self.loginUseCase = loginUseCase
        self.logoutUseCase = logoutUseCase
        self.restoreSessionUseCase = restoreSessionUseCasse
        self.getRememberedCredentialUseCase = getRememberedCredentialUseCase
        self.deleteRememberedCredentialUseCase = deleteRememberedCredentialUseCase
        self.existRememberedCredentialUseCase = existRememberedCredentialUseCase
    }
    
    //    Page: 0 -> Login, 1 -> Home
    
    
    func login() async -> Bool  {
        CustomLog.debug(category: .VM, "\(#function)")
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
            Crashlytics.crashlytics().setUserID(idUser)
            self.idUser = idUser
            showProgressView = false
            return true
        } catch  {
            showError(from: error)
            return false
        }
    }
    
    func restoreSession() -> Bool {
        CustomLog.debug(category: .VM, "\(#function)")
        do {
            try restoreSessionUseCase.execute()
            Crashlytics.crashlytics().setUserID(self.idUser)
            return true
        } catch  {
            return false
        }
    }
    
    func logOut() -> Bool{
        do {
            try  logoutUseCase.execute()
            self.idUser = ""
            Crashlytics.crashlytics().setUserID(self.idUser)
            self.clear()
            return true
        } catch {
            showError(from: error)
            return false
        }
    }
    
    func deleteRememberCredential() {
        CustomLog.debug(category: .VM, "\(#function)")
        deleteRememberedCredentialUseCase.execute()
        checkStatus()
    }
    
    func checkStatus() {
        CustomLog.debug(category: .VM, "\(#function)")
        canShowAutoFill = existRememberedCredentialUseCase.execute()
    }
    
    func loadRememberCredential() {
        CustomLog.debug(category: .VM, "\(#function)")
        do {
            let credential = try getRememberedCredentialUseCase.execute()
            self.email = credential.email
            self.password = credential.password
        } catch  {
            showError(from: error)
        }
    }
    
    private func clear() {
        self.email = ""
        self.password = ""
        self.errorMessage = ""
        self.showError = false
        self.showProgressView = false
    }
    
    private func showError(from error: Error) {
        CustomLog.error(category: .VM, "\(error.localizedDescription)")
        Utils.showError(alertMessage: &errorMessage, showAlert: &showError, from: error)
    }
    
}
