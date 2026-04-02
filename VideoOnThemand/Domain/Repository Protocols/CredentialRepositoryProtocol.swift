//
//  CredentialRepositoryProtocol.swift
//  VideoOnThemand
//
//  Created by Michele Manniello on 31/03/26.
//

import Foundation

protocol CredentialRepositoryProtocol {
    func readCredential() throws -> (email: String, password: String) 
    func saveCredential(email: String, password: String) 
}
