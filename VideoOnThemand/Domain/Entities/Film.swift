//
//  Film.swift
//  VideoOnThemand
//
//  Created by Michele Manniello on 09/08/22.
//

import UIKit
import SwiftUI
import FirebaseFirestore


struct Film: Identifiable, Codable {
    
    //  MARK:  ID Recuperato da query firebase
    var id: String
    var idUtente: String
    var nome: String
    var url: String
    var thumbnail: String
    var size: Double
    var data: Date?
    
    init(){
        id = UUID().uuidString
        idUtente = ""
        nome = ""
        url = ""
        thumbnail =  ""
        size = 0
        data = .now
        
    }
    
    init(nome: String) {
        id = UUID().uuidString
        idUtente = ""
        self.nome = nome
        url = ""
        thumbnail = ""
        size = 45
        data = .now
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
        self.data = .now
        
    }
}

var mockFilms: [Film] {
    var array = [Film]()
    for i in 0...11 {
        array.append(Film(nome: "OnePiece_Ep_\(i)_SUB_ITA.mp4"))
    }
    return array
    
}

