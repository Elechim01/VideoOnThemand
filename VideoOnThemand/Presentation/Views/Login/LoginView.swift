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
    @State private var showDeleteRememberedCredential: Bool = false
    
    init(loginViewModel: LoginViewModel) {
        self.loginViewModel = loginViewModel
    }
    
    var body: some View {
        ZStack {
            VStack(spacing: 40) {
                VStack(spacing: 20) {
                    Text("LOGIN.TITLE".localized())
                        .font(.title)
                    
                    Text("LOGIN.SUBTITLE".localized())
                        .font(.title2)
                }
                .padding(.top, 60)
                
                VStack(spacing: 30) {
                    VStack(alignment: .leading, spacing: 15) {
                        HStack {
                            Image(systemName: "envelope")
                                .font(.title2)
                            
                            Text("LOGIN.EMAIL.TEXT".localized())
                                .font(.title2)
                        }
                        
                        TextField("LOGIN.TEXTFIELD.EMAIL".localized(), text: $loginViewModel.email)
                            .font(.title2)
                            .padding()
                            .glassEffect(.regular, in: .buttonBorder)
                    }
                    
                    VStack(alignment: .leading, spacing: 15) {
                        HStack {
                            Image(systemName: "lock")
                                .font(.title2)
                            
                            Text("LOGIN.PASSWORD.TEXT".localized())
                                .font(.title2)
                        }
                        
                        SecureField("LOGIN.TEXTFIELD.EMAIL".localized(), text: $loginViewModel.password)
                            .font(.title2)
                            .padding()
                            .glassEffect(.regular, in: .buttonBorder)
                    }
                }
                .padding(.horizontal, 100)
                
                HStack {
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
                    
                    if loginViewModel.canShowAutoFill {
                        Button(action: {
                            loginViewModel.loadRememberCredential()
                        }, label: {
                            Label("LOGIN.REMEMBER.CREDENTIAL".localized(), systemImage: "key.fill")
                                .font(.title2)
                        })
                        .glassEffect(.regular, in: .capsule)
                    }
                    
                    Button(action: {
                        showDeleteRememberedCredential.toggle()
                    }, label: {
                        Image(systemName: "trash")
                            .font(.title3)
                            .fontWeight(.semibold)
                            .padding(.vertical, 20)
                            .padding(.horizontal, 60)
                    })
                    .glassEffect(.regular, in: .capsule)
                    
                }

                Spacer()
            }
            if loginViewModel.showProgressView {
                CustomProgressView()
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(AppColors.backgroundGradient(for: colorScheme).ignoresSafeArea())
        .onAppear(perform: {
            self.loginViewModel.checkStatus()
        })
        .alert("LOGIN.REMOVE.CREDENTIAL".localized(), isPresented: $showDeleteRememberedCredential) {
            Button("LOGIN.REMOVE.CREDENTIAL.CANCEL".localized(), role: .cancel) { }
            Button("LOGIN.REMOVE.CREDENTIAL.DELETE".localized(), role: .destructive) {
                loginViewModel.deleteRememberCredential()
            }
        } message: {
            Text("LOGIN.REMOVE.CREDENTIAL.MESSAGE".localized())
        }
        .alert(loginViewModel.errorMessage, isPresented: $loginViewModel.showError, actions: {
            Button("LOGIN.OK".localized(), role: .cancel) {
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
