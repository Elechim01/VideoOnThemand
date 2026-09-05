//
//  LogoutUseCase.swift
//  VideoOnThemand
//
//  Created by Michele Manniello on 31/03/26.
//

import Foundation

final class LogoutUseCase: Sendable {
    private let repository: AuthRepositoryProtocol
    
    init(repository: AuthRepositoryProtocol) {
        self.repository = repository
    }
    
    func execute() throws {
        try repository.logOut()
    }
}
