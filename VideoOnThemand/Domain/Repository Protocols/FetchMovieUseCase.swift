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
    
    func execute(localUserId: String) async -> AsyncThrowingStream<[Film],Error>  {
        return await movieRepository.loadFilms(localUserId: localUserId)
        
    }
}
