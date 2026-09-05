//
//  RestoreSessionUseCase.swift
//  VideoOnThemand
//
//  Created by Michele Manniello on 31/03/26.
//

import Foundation

final class RestoreSessionUseCase: Sendable {
    private let repository: CredentialRepositoryProtocol
    
    init(repository: CredentialRepositoryProtocol) {
        self.repository = repository
    }
    
    func execute() throws {
     let _ = try repository.readCredential()
    }
}
