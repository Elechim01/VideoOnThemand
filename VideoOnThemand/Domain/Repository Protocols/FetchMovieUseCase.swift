//
//  FetchMovieUseCase.swift
//  VideoOnThemand
//
//  Created by Michele Manniello on 31/03/26.
//

import Foundation

class FetchMovieUseCase {
    private let movieRepository: MovieRepositoryProtocol
    
    init(movieRepository: MovieRepositoryProtocol) {
        self.movieRepository = movieRepository
    }
    
    func execute(localUserId: String) async throws -> AsyncStream<[Film]> {
        return try await movieRepository.loadFilms(localUserId: localUserId)
        
    }
}
