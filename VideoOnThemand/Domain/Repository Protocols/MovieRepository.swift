//
//  MovieRepository.swift
//  VideoOnThemand
//
//  Created by Michele Manniello on 31/03/26.
//

import Foundation
import Services

final class MovieRepository: MovieRepositoryProtocol {
    func loadFilms(localUserId: String) async -> AsyncThrowingStream<[Film],Error> {
        return await FirebaseUtils.shared.recuperoFilm(localUserId: localUserId)
    }
}
