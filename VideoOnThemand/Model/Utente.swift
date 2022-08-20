//
//  Utenti.swift
//  VideoOnThemand
//
//  Created by Michele Manniello on 09/08/22.
//

import SwiftUI
import UIKit

struct Utente: Identifiable {
//   MARK: Id preso da frebase 
    var id: String
    var nome: String
    var cogome: String
    var età : Int
    var email: String
    var password: String
    var cellulare: String
    
    var isEmply: Bool{
        if(id == "" && nome == "" && cogome == "" && età == 0 && email == "" && password == "" && cellulare == ""){
            return true
        }else{
            return false
        }
    }
    
    init() {
        id = ""
        nome = ""
        cogome = ""
        età = 0
        email = ""
        password = ""
        cellulare = ""
    }
    init(id: String,
         nome:String,
         cognome: String,
         età: Int,
         email: String,
         password: String,
         cellulare: String){
        
        self.id = id
        self.nome = nome
        self.cogome = cognome
        self.età = età
        self.email = email
        self.password = password
        self.cellulare = cellulare
    }
    
}

