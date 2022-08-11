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
    
  
   
}
