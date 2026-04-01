//
//  FetchChronology.swift
//  VideoOnThemand
//
//  Created by Michele Manniello on 30/03/26.
//

import Foundation
class FetchChronologyUseCase {
    private let chronologyRepository: ChronologyRepositoryProtocol
    
    init(chronologyRepository: ChronologyRepositoryProtocol) {
        self.chronologyRepository = chronologyRepository
    }
    
    func execute(localUser: String) async throws -> AsyncStream<[Chronology]> {
        return try await chronologyRepository.loadChronology(localUser: localUser)
    }
}
