//
//  FetchChronology.swift
//  VideoOnThemand
//
//  Created by Michele Manniello on 30/03/26.
//

import Foundation
import Services

class FetchChronologyUseCase {
    private let chronologyRepository: ChronologyRepositoryProtocol
    
    init(chronologyRepository: ChronologyRepositoryProtocol) {
        self.chronologyRepository = chronologyRepository
    }
    
    func execute(localUser: String) async  ->  AsyncThrowingStream<[Chronology], Error> {
        return  await chronologyRepository.loadChronology(localUser: localUser)
    }
}
