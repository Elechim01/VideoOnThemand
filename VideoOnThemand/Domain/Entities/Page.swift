//
//  Enums.swift
//  VideoOnThemand
//
//  Created by Michele Manniello on 12/03/23.
//

import Foundation
enum Page: Int {
    case Login = 0
    case Home = 1
    
    static func setValue(valore: Int) -> Page {
        if(valore == 0) {
            return .Login
        }
        if(valore == 1) {
            return .Home
        }
        return .Login
    }
}
