//
//  LoginUseCase.swift
//  VideoOnThemand
//
//  Created by Michele Manniello on 31/03/26.
//

import Foundation

class LoginUseCase {
    
    private let authRepository: AuthRepositoryProtocol
    private let credentialRepository: CredentialRepositoryProtocol
    
    init(authRepository: AuthRepositoryProtocol, credentialRepository: CredentialRepositoryProtocol) {
        self.authRepository = authRepository
        self.credentialRepository = credentialRepository
    }
    
    func execute(email: String, password: String) async throws -> String {
        let id = try await authRepository.signIn(email: email, password: password)
        credentialRepository.saveCredential(email: email, password: password)
        return id
    }
    
}
