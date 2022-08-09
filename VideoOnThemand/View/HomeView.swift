//
//  HomeView.swift
//  VideoOnThemand
//
//  Created by Michele Manniello on 09/08/22.
//

import SwiftUI

struct HomeView: View {
    @State private var page = 0
    @State private var showAlert = false
    @EnvironmentObject var loginViewModel: LoginViewModel
    var body: some View {
        VStack {
            Picker("Page", selection: $page) {
                Text("Video").tag(0)
                Text("Impostazioni").tag(1)
            }
            .frame(maxWidth: 600)
            .clipShape(Capsule())
            
            if(page == 0){
                
                HStack {
                    Spacer()
                    List {
                        Section("Utente") {
                            Button {
                                showAlert.toggle()
                            } label: {
                                Text("Logout")
                            }
                            .frame(width: 800,height: 60)
                            .background(Color.gray.opacity(0.5))
                            .cornerRadius(13)
                        }
                       
                        
                       
                        
                        Button {
                            print(2)
                        } label: {
                            Text("A Second Item")
                        }
                        .frame(width: 800,height: 60)
                        .background(Color.gray.opacity(0.5))
                        .cornerRadius(13)
                    
                        
                        Button {
                            print(3)
                        } label: {
                            Text("A Third Item")
                        }
                        .frame(width: 800,height: 60)
                        .background(Color.gray.opacity(0.5))
                        .cornerRadius(13)
                      }
                    .frame(width: 800)
                    .padding()
                }
                .padding()
                
                
            }else{
                
            }
            
            Spacer()
        }
        .alert("Sei Sicuro di voler effettuare il Logout?", isPresented: $showAlert) {
            Button("Annulla",role: .cancel){
                showAlert.toggle()
            }
            
            Button("Conferma",role: .destructive){
                loginViewModel.logOut()
                showAlert.toggle()
                
            }


        }
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
