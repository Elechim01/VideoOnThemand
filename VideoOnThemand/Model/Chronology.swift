//
//  Chronology.swift
//  VideoOnThemand
//
//  Created by Michele Manniello on 25/08/25.
//

import Foundation

struct Chronology: Identifiable, Codable {
    var id: String = UUID().uuidString
    var dateTime: String
    var filmName: String
    var idFilm: String
    var localUser:String
    
    var date: Date {
        Self.getFormatter().date(from: dateTime) ?? .now
    }
    
    init(film: Film, localUser: String) {
        self.dateTime = Self.getFormatter().string(from: .now)
        self.filmName = film.nome
        self.idFilm = film.id
        self.localUser = localUser
        
    }
    
    static func getFormatter() -> DateFormatter {
        let formatter = DateFormatter()
        formatter.dateFormat = "dd/MM/yyyy HH:mm:ss"
        formatter.timeZone = .current
        return formatter
    }
    
    enum CodingKeys: String, CodingKey {
       
      case id
      case dateTime
      case filmName
      case idFilm
      case localUser = "idUtente"
    }
    
    static func getChronology(json: [String: Any]) -> Chronology? {
        do {
            let data = try JSONSerialization.data(withJSONObject: json)
                let decode = JSONDecoder()
            let chronology = try decode.decode(Self.self, from: data)
            return chronology
        } catch {
            return nil
        }
    }
}

var mockChronology: [Chronology] = mockFilms.map { film in
    Chronology(film: film, localUser: "zglR4HvR0sP3KEqaRGL8Ma5cx5t2")
}
