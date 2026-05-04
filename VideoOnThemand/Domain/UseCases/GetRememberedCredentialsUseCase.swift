//
//  GetRememberedCredentialsUseCase.swift
//  VideoOnThemand
//
//  Created by Michele Manniello on 29/04/26.
//

import Foundation

final class GetRememberedCredentialsUseCase {
    private let repository: CredentialRepositoryProtocol
    
    init(repository: CredentialRepositoryProtocol) {
        self.repository = repository
    }
    
    func execute() throws -> (email: String, password: String) {
        try repository.readRememberedCredential()
    }
}
