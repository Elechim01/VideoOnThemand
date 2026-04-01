//
//  AuthRepository.swift
//  VideoOnThemand
//
//  Created by Michele Manniello on 31/03/26.
//

import Foundation
import Services
import ElechimCore
import FirebaseAuth

final class AuthRepository: AuthRepositoryProtocol {
    func getCurentUser(userId: String, email: String, password: String) async throws -> Utente {
        guard let user: Utente =  try await FirebaseUtils.shared.recuperoUtente(email: email,
                                                                                password: password,
                                                                                id: userId) else {
            throw CustomError.noUser
        }
        return user
    }
    
    func logOut() throws {
        let firebase = Auth.auth()
        try firebase.signOut()
        AuthKeyChain.shared.delete()
        
    }
    
    func signIn(email: String, password: String) async throws -> String {
        let authResult = try await FirebaseUtils.shared.signIn(email: email, password: password)
        return authResult.user.uid
    }
}
