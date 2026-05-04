//
//  DeleteRememberedCredentialsUseCase.swift
//  VideoOnThemand
//
//  Created by Michele Manniello on 29/04/26.
//

import Foundation

final class DeleteRememberedCredentialsUseCase {
    private let repository: CredentialRepositoryProtocol
    
    init(repository: CredentialRepositoryProtocol) {
        self.repository = repository
    }
    
    func execute() {
        repository.deleteRememberedCredential()
    }
}
