//
//  CredentialRepositoryProtocol.swift
//  VideoOnThemand
//
//  Created by Michele Manniello on 31/03/26.
//

import Foundation

protocol CredentialRepositoryProtocol {
    func readCredential() throws -> (email: String, password: String) 
    func saveCredential(email: String, password: String)  throws
    func readRememberedCredential() throws -> (email: String, password: String)
    func saveRememberedCredential(email: String, password: String) throws
    func deleteCredential()
    func deleteRememberedCredential()
    func existRememberedCredentials() -> Bool
}
