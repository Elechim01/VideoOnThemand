//
//  UpdateChronologyUseCase.swift
//  VideoOnThemand
//
//  Created by Michele Manniello on 31/03/26.
//

import Foundation

class UpdateChronologyUseCase {
    private let chronologyRepository: ChronologyRepositoryProtocol
    
    init(chronologyRepository: ChronologyRepositoryProtocol) {
        self.chronologyRepository = chronologyRepository
    }
    
    func execute(film: Film, localUserId: String) async throws {
        let chronology = Chronology(film: film, localUsedId: localUserId)
        return try await chronologyRepository.updatePlay(
            chronology: chronology,
            filmId: film.id)
    }
}
