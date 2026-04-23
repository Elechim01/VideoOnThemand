//
//  MovieRepositoryProtocol.swift
//  VideoOnThemand
//
//  Created by Michele Manniello on 31/03/26.
//

import Foundation
import Services

protocol MovieRepositoryProtocol: Sendable {
    func loadFilms(localUserId: String) async -> AsyncThrowingStream<[Film],Error> 
}
