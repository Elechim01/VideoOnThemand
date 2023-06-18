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

extension View {
    func snapshot() -> UIImage {
        let controller = UIHostingController(rootView: self)
        let view = controller.view
        let size = controller.sizeThatFits(in: UIScreen.main.bounds.size)
        view?.bounds = CGRect(origin: .zero, size: size)
        view?.backgroundColor = .clear
        
        let renderer = UIGraphicsImageRenderer(size: size)
        return renderer.image { _ in
            view?.drawHierarchy(in: view?.bounds ?? CGRect.zero, afterScreenUpdates: true)
        }
    }
}

extension String {
  static func twoDecimal(number: Double) -> String {
        String(format: "%.2fMB", number)
    }
}

