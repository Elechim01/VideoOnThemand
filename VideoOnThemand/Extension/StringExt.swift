//
//  StringExt.swift
//  VideoOnThemand
//
//  Created by Michele Manniello on 16/08/25.
//

import Foundation

extension String {
    func localized(_ args: CVarArg...,comment: String = "") -> String {
        let format =  NSLocalizedString(self, comment: comment)
        return String(format: format, arguments: args)
    }
    
    static func twoDecimalMB(number: Double) -> String {
        String(format: "%.2f MB", number)
    }
    
    static func twoDecimalGB(number: Double) -> String {
        String(format: "%.2f GB", number)
    }
}
