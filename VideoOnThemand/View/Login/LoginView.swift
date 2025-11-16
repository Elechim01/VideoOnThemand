//
//  LoginView.swift
//  VideoOnThemand
//
//  Created by Michele Manniello on 09/08/22.
//

import SwiftUI
import Combine

struct LoginView: View {
    
    @State var email: String = ""
    @State var password: String = ""
    @EnvironmentObject var loginViewModel: LoginViewModel
    @EnvironmentObject var homeViewModel: HomeViewModel
    @Environment(\.colorScheme) var colorScheme
    
    // Detect the current UI mode (light / dark)
   
    
    var getCheck: Bool {
        if email.isEmpty {
            loginViewModel.errorMessage = "Il campo email è vuoto"
            return false
        }
        if !Extensions.isValidEmail(email) {
            loginViewModel.errorMessage = "L'email non è valida"
            return false
        }
        if password.isEmpty {
            loginViewModel.errorMessage = "Il campo password è vuoto"
            return false
        }
        if !Extensions.isValidPassword(testStr: password) {
            loginViewModel.errorMessage = "La password non è valida, deve comprendere: Almeno una maiuscola, Almeno un numero, Almeno una minuscola, 8 caratteri in totale"
            return false
        }
        return true
    }
    
   
    
    var body: some View {
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
                    
                    TextField("Inserisci email", text: $email)
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
                    
                    SecureField("Inserisci password", text: $password)
                        .font(.title2)
                        .padding()
                        .glassEffect(.regular, in: .buttonBorder)
                }
            }
            .padding(.horizontal, 100)
            
            Button(action: {
                performLoginIfValid()
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
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(AppColors.backgroundGradient(for: colorScheme).ignoresSafeArea())
        .alert(loginViewModel.errorMessage, isPresented: $loginViewModel.showError, actions: {
            Button("OK", role: .cancel) {
                loginViewModel.showError = false
            }
        })
        .alert(homeViewModel.alertMessage, isPresented: $homeViewModel.showAlert, actions: {
            Button("OK", role: .cancel) {
                homeViewModel.showAlert = false
            }
        })
    }
    
    private func performLoginIfValid() {
        if getCheck {
            loginViewModel.login(email: email, password: password) { id in
                if !id.isEmpty {
                    self.homeViewModel.recuperoUtente(email: email, password: password, id: id) {
                        if !homeViewModel.showAlert {
                            loginViewModel.localPage = .Home
                        }
                    }
                } else {
                    loginViewModel.showError = true
                }
            }
        } else {
            loginViewModel.showError = true
        }
    }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
            .environmentObject(LoginViewModel())
            .environmentObject(HomeViewModel())
    }
}
