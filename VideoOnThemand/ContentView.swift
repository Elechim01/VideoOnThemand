//
//  ContentView.swift
//  VideoOnThemand
//
//  Created by Michele Manniello on 09/08/22.
//

import SwiftUI

struct ContentView: View {
    
    @StateObject var loginViewModel = LoginViewModel()
    
    @StateObject var homeViewModel = HomeViewModel()
    
    var body: some View {
        if(loginViewModel.page == 0){
            LoginView()
                .environmentObject(loginViewModel)
                .environmentObject(homeViewModel)
        } else if(loginViewModel.page == 1){
          HomeView()
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
