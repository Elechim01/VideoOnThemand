//
//  ChronologyRepositoryProtocol.swift
//  VideoOnThemand
//
//  Created by Michele Manniello on 30/03/26.
//

import Foundation
import Services

protocol ChronologyRepositoryProtocol: Sendable {
    func loadChronology(localUser: String) async  -> AsyncThrowingStream<[Chronology], Error>
    func updatePlay(chronology: Chronology) async throws
}
