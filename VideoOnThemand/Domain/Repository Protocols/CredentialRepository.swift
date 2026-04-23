//
//  CredentialRepository.swift
//  VideoOnThemand
//
//  Created by Michele Manniello on 31/03/26.
//

import Foundation
import Services
import ElechimCore

class CredentialRepository: CredentialRepositoryProtocol {
    func readCredential() throws -> (email: String, password: String) {
        let credential = AuthKeyChain.shared.redCredential()
        guard let email = credential.email,
              let password = credential.password else {
            throw CustomError.noCredential
        }
        return (email, password)
    }
    
    func saveCredential(email: String, password: String) throws {
       try AuthKeyChain.shared.setCredential(email: email, password: password)
    }
}
