//
//  AuthRepositoryProtocol.swift
//  VideoOnThemand
//
//  Created by Michele Manniello on 31/03/26.
//

import Foundation
import Services

protocol AuthRepositoryProtocol: Sendable {
    func getCurentUser(userId: String) async throws -> Utente
    func signIn(email: String, password: String) async throws ->  String
    func logOut() throws
}
