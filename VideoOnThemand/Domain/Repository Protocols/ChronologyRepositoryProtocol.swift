//
//  ChronologyRepositoryProtocol.swift
//  VideoOnThemand
//
//  Created by Michele Manniello on 30/03/26.
//

import Foundation

protocol ChronologyRepositoryProtocol: Sendable {
    func loadChronology(localUser: String) async  -> AsyncThrowingStream<[Chronology], Error>
    func updatePlay(chronology: Chronology, filmId: String) async throws
}
