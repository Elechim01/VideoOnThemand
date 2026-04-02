//
//  GetCurrentUserUseCase.swift
//  VideoOnThemand
//
//  Created by Michele Manniello on 31/03/26.
//

import Foundation
import Services
import ElechimCore

class GetCurrentUserUseCase {
    private let authRepository: AuthRepositoryProtocol
    private let credentialRepository: CredentialRepositoryProtocol
    
    init(authRepository: AuthRepositoryProtocol, credentialRepository: CredentialRepositoryProtocol) {
        self.authRepository = authRepository
        self.credentialRepository = credentialRepository
    }
    
    func execute(userId: String) async throws -> Utente {
        let credential =  try credentialRepository.readCredential()
        
        return try await  authRepository.getCurentUser(userId: userId,
                                                       email: credential.email,
                                                       password: credential.password)
    }
}
