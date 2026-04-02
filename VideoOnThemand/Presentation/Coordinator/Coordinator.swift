//
//  Coordinator.swift
//  VideoOnThemand
//
//  Created by Michele Manniello on 31/03/26.
//

import Foundation
import SwiftUI

@MainActor
class Coordinator: ObservableObject {
    
    @Published var homeViewModel: HomeViewModel
    @Published var loginViewModel: LoginViewModel
    @Published var chronologyViewModel: ChronologyViewModel
    @Published var user: Utente?
    
    private static let dependecyContainer = DependecyContainer()
    
    @AppStorage("CurrentPage") var currentPage: Page = .Login
    
    init() {
        self.homeViewModel = Self.dependecyContainer.makeHomeViewModel()
        self.loginViewModel = Self.dependecyContainer.makeLoginViewModel()
        self.chronologyViewModel = Self.dependecyContainer.makeChronologyViewModel()
    }
    
    func login() async {
        let result = await loginViewModel.login()
        if result {
            await startHome()
            
        }
    }
    
    func restoreSession() async {
        let isRestored =  loginViewModel.restoreSession()
        if isRestored {
            await startHome()
        }
    }
    
    func startHome() async {
        await homeViewModel.start()
        currentPage = .Home
    }
    
    func logout() {
        if loginViewModel.logOut() {
            currentPage = .Login
        }
    }
}
