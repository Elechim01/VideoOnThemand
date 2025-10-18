//
//  Extensions.swift
//  VideoOnThemand
//
//  Created by Michele Manniello on 09/08/22.
//

import SwiftUI
import UIKit
import Alamofire

class Extensions{
    
    static func isConnectedToInternet()->Bool{
        return NetworkReachabilityManager()!.isReachable
    }
    
    static func getDocumentsDirectory() -> URL{
  //        find all possible documents directories for ths user
        let paths = FileManager.default.urls(for: .cachesDirectory, in: .userDomainMask)
  //        Just send back the first one, witch ought to be only one
          return paths[0]
      }
    
 static   func isValidEmail(_ email: String) -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"

        let emailPred = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailPred.evaluate(with: email)
    }
    
  static  func isValidPassword(testStr:String?) -> Bool {
        guard testStr != nil else { return false }

        // almeno una maiuscola,
        // almeno una cifra
        // almeno una minuscola
        // 8 caratteri in totale
        
        let passwordTest = NSPredicate(format: "SELF MATCHES %@", "(?=.*[A-Z])(?=.*[0-9])(?=.*[a-z]).{8,}")
        return passwordTest.evaluate(with: testStr)
    }
}

extension EnvironmentValues {
    var isPreview: Bool {
         #if DEBUG
         return ProcessInfo.processInfo.environment["XCODE_RUNNING_FOR_PREVIEWS"] == "1"
 //        || true
         #else
         return false
         #endif
     }
}

