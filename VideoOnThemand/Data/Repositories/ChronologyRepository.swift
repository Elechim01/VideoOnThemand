//
//  ChronologyRepository.swift
//  VideoOnThemand
//
//  Created by Michele Manniello on 30/03/26.
//

import Foundation
import Services

final class ChronologyRepository: ChronologyRepositoryProtocol {
    
    func loadChronology(localUser: String) async -> AsyncThrowingStream<[Chronology], Error> {
        return await FirebaseUtils.shared.recuperoChronology(localUser: localUser)
    }
    
    func updatePlay(chronology: Chronology) async throws {
        return try await FirebaseUtils.shared.updatePlay(chronology: chronology)
    }
    
}
