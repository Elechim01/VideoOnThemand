//
//  CredentialRepository.swift
//  VideoOnThemand
//
//  Created by Michele Manniello on 31/03/26.
//

import Foundation
import Services
import ElechimCore

final class CredentialRepository: CredentialRepositoryProtocol {
    
    func readCredential() throws -> (email: String, password: String) {
        let credential = AuthKeyChain.shared.redCredential()
        guard let email = credential.email,
              let password = credential.password else {
            throw CustomError.noCredential
        }
        return (email,password)
    }
    
    func saveCredential(email: String, password: String) throws {
        try AuthKeyChain.shared.setCredential(email: email, password: password)
    }
    
    func deleteCredential() {
        AuthKeyChain.shared.delete()
    }
    
    func readRememberedCredential() throws -> (email: String, password: String) {
        let credential = AuthKeyChain.shared.readRemeberedCredential()
        guard let email = credential.email,
              let password = credential.password else {
            throw CustomError.noCredential
        }
        return (email,password)
    }
    
    func saveRememberedCredential(email: String, password: String) throws {
        try AuthKeyChain.shared.setRemeberedCredential(email: email, password: password)
    }
    
    func deleteRememberedCredential() {
        AuthKeyChain.shared.deleteRemeberedCredential()
    }
    
    func existRememberedCredentials() -> Bool {
        AuthKeyChain.shared.rememberedCredentialExist()
    }
    
}

