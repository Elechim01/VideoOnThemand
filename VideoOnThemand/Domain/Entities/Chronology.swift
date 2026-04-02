//
//  Chronology.swift
//  VideoOnThemand
//
//  Created by Michele Manniello on 25/08/25.
//

import Foundation

struct Chronology: Identifiable, Codable {
    var id: String = UUID().uuidString
    var date: Date
    var filmName: String
    var idFilm: String
    var localUserId:String
    
    
    init(film: Film, localUsedId: String) {
        self.date = .now
        self.filmName = film.nome
        self.idFilm = film.id
        self.localUserId = localUsedId
    }
    
    enum CodingKeys: String, CodingKey {
        case id
        case date
        case filmName
        case idFilm
        case localUserId = "idUtente"
    }
    
}

var mockChronology: [Chronology] = mockFilms.map { film in
    Chronology(film: film, localUsedId: "zglR4HvR0sP3KEqaRGL8Ma5cx5t2")
}
