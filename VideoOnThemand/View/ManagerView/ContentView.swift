//
//  ContentView.swift
//  VideoOnThemand
//
//  Created by Michele Manniello on 09/08/22.
//

import SwiftUI
import UIKit

struct ContentView: View {
    
    @StateObject var loginViewModel = LoginViewModel()
    
    @StateObject var homeViewModel = HomeViewModel()
    
    
    var body: some View {
        
        if(loginViewModel.localPage == .Login){
            LoginView()
                .environmentObject(loginViewModel)
                .environmentObject(homeViewModel)
            
        } else if(loginViewModel.localPage == .Home){
           PageManager()
                .environmentObject(loginViewModel)
                .environmentObject(homeViewModel)
        }
        
    }
    
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}


