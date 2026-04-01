//
//  AuthRepositoryProtocol.swift
//  VideoOnThemand
//
//  Created by Michele Manniello on 31/03/26.
//

import Foundation

protocol AuthRepositoryProtocol {
    func getCurentUser(userId: String, email: String, password: String) async throws -> Utente
    func signIn(email: String, password: String) async throws ->  String
    func logOut() throws
}
