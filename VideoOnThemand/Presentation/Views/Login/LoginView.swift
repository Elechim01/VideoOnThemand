//
//  LoginView.swift
//  VideoOnThemand
//
//  Created by Michele Manniello on 09/08/22.
//

import SwiftUI

struct LoginView: View {
    @EnvironmentObject var coordinator: Coordinator
    @ObservedObject var loginViewModel: LoginViewModel
    @Environment(\.colorScheme) var colorScheme
    
    init(loginViewModel: LoginViewModel) {
        self.loginViewModel = loginViewModel
    }
    
    var body: some View {
        ZStack {
            VStack(spacing: 40) {
                VStack(spacing: 20) {
                    Text("Benvenuto in app.")
                        .font(.title)
                    
                    Text("Effettua l'accesso per visionare i video")
                        .font(.title2)
                }
                .padding(.top, 60)
                
                VStack(spacing: 30) {
                    VStack(alignment: .leading, spacing: 15) {
                        HStack {
                            Image(systemName: "envelope")
                                .font(.title2)
                            
                            Text("Email")
                                .font(.title2)
                        }
                        
                        TextField("Inserisci email", text: $loginViewModel.email)
                            .font(.title2)
                            .padding()
                            .glassEffect(.regular, in: .buttonBorder)
                    }
                    
                    VStack(alignment: .leading, spacing: 15) {
                        HStack {
                            Image(systemName: "lock")
                                .font(.title2)
                            
                            Text("Password")
                                .font(.title2)
                        }
                        
                        SecureField("Inserisci password", text: $loginViewModel.password)
                            .font(.title2)
                            .padding()
                            .glassEffect(.regular, in: .buttonBorder)
                    }
                }
                .padding(.horizontal, 100)
                
                Button(action: {
                    Task {
                        await coordinator.login()
                    }
                }, label: {
                    Text("Login")
                        .font(.title2)
                        .fontWeight(.semibold)
                        .padding(.vertical, 20)
                        .padding(.horizontal, 60)
                })
                .glassEffect(.regular, in: .capsule)
                
                Spacer()
            }
            if loginViewModel.showProgressView {
                CustomProgressView()
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(AppColors.backgroundGradient(for: colorScheme).ignoresSafeArea())
        .alert(loginViewModel.errorMessage, isPresented: $loginViewModel.showError, actions: {
            Button("OK", role: .cancel) {
                loginViewModel.showError = false
            }
        })
    }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView(loginViewModel: Coordinator().loginViewModel)
            .environmentObject(Coordinator())
    }
}
