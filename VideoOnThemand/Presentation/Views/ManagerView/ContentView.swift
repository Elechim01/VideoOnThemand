//
//  ContentView.swift
//  VideoOnThemand
//
//  Created by Michele Manniello on 09/08/22.
//

import SwiftUI
import UIKit

struct ContentView: View {
    @EnvironmentObject var coordinator: Coordinator
    var body: some View {
        Group {
            switch coordinator.currentPage {
            case .Login:
                LoginView(loginViewModel: coordinator.loginViewModel)
            case .Home:
                PageManager(homeViewModel: coordinator.homeViewModel, chronologyViewModel: coordinator.chronologyViewModel)
            }
        }
        .environmentObject(coordinator)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .environmentObject(Coordinator())
    }
}


