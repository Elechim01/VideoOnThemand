//
//  SettingsView.swift
//  VideoOnThemand
//
//  Created by Michele Manniello on 10/08/22.
//

import SwiftUI

struct SettingsView: View {
    @Binding var showAlert: Bool
    var body: some View {
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
    
        
    }
   
}

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
