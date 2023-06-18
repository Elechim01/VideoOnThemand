//
//  Film.swift
//  VideoOnThemand
//
//  Created by Michele Manniello on 09/08/22.
//

import UIKit
import SwiftUI


struct Film: Identifiable, Codable {
    
//  MARK:  ID Recuperato da query firebase 
    var id: String
    var idUtente: String
    var nome: String
    var url: String
    var thumbnail: String
    var size: Double
    
    init(){
        id = UUID().uuidString
        idUtente = ""
        nome = ""
        url = ""
        thumbnail =  ""
        size = 0
    }
    
    init(nome: String) {
        id = UUID().uuidString
        idUtente = ""
        self.nome = nome
        url = ""
        thumbnail = ""
        size = 45
    }
    
    
    init(id : String,
         idUtente: String,
         nome: String,
         url: String,
         thmbnail: String,
         size: Double){
        self.id = id
        self.idUtente = idUtente
        self.nome = nome
        self.url = url
        self.thumbnail = thmbnail
        self.size = size
        
    }
    
    func getData() -> [String:Any]? {
        do {
            let data = try JSONEncoder().encode(self)
            let json = try JSONSerialization.jsonObject(with: data, options: []) as? [String:Any]
            return json
        } catch  {
            return nil
        }
    }
    
    static func getFilm(json: [String: Any]) -> Film? {
        do {
            let data = try JSONSerialization.data(withJSONObject: json)
            let film = try JSONDecoder().decode(Self.self, from: data)
            return film
        } catch  {
            return nil
        }
    }
    
}

var mockFilms: [Film] {
var array = [Film]()
    let lettere = "abcdefghijklmnopqrstuvwxyz"
    for _ in 1...15 {
        guard let tes = lettere.randomElement() else { return [] }
        array.append(Film(nome: "\(tes)"))
    }
    return array
    
}

