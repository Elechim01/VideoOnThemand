//
//  Film.swift
//  VideoOnThemand
//
//  Created by Michele Manniello on 09/08/22.
//

import UIKit
import SwiftUI


struct Film: Identifiable {
    
//  MARK:  ID Recuperato da query firebase 
    var id : String
    var idUtente: String
    var nome: String
    var url: String
    var thmbnail: Image
    
    
    init(){
        id = ""
        idUtente = ""
        nome = ""
        url = ""
        thmbnail = Image("backgroundImage")
    }
    
    
    init(id : String,
         idUtente: String,
         nome: String,
         url: String,
         thmbnail: Image){
        self.id = id
        self.idUtente = idUtente
        self.nome = nome
        self.url = url
        self.thmbnail = thmbnail
        
    }
    
}
