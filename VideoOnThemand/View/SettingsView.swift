//
//  SettingsView.swift
//  VideoOnThemand
//
//  Created by Michele Manniello on 10/08/22.
//

import SwiftUI
import Charts

struct SettingsView: View {
    @Environment(\.isPreview) var isPreviews
    @Binding var showAlert: Bool
    @EnvironmentObject var homeViewModel: HomeViewModel
  
    var body: some View {
        HStack {
            
            VStack(alignment: .leading) {
                
                Text("Name: \(homeViewModel.localUser.nome)")
                    .font(.title2)
                    .fontWeight(.bold)
                    .padding(.vertical)
                
                Text("Surname: \(homeViewModel.localUser.cognome)")
                    .font(.title3)
                    .padding(.vertical)
                
                Divider()
                
                Text("Cell: \(homeViewModel.localUser.cellulare)")
                    .font(.system(size: 40))
                    .padding(.vertical)
                
                Divider()
                
                Text("Email: \(homeViewModel.localUser.email)")
                    .font(.system(size: 40))
                    .padding(.vertical)
                
                Text("Password: \(homeViewModel.localUser.password)")
                    .font(.system(size: 40))
                    .padding(.vertical)
                Spacer()
            }
           
            Spacer()
            VStack {
                List {
                    Section("Utente") {
                  
                        Button {
                            homeViewModel.showGrid.toggle()
                        } label: {
                            Text(homeViewModel.showGrid ? "Passa a lista" : "Passa a griglia")
                        }
                        .frame(width: 800,height: 60)
                        .background(Color.gray.opacity(0.5))
                        .cornerRadius(13)
                    
                        
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
                        homeViewModel.orderAscending.toggle()
                    } label: {
                        Text(homeViewModel.orderAscending ? "Passa a discendente" : "Passa a ascendente")
                    }
                    .frame(width: 800,height: 60)
                    .background(Color.gray.opacity(0.5))
                    .cornerRadius(13)
                                    
                  }
                Chart(isPreviews ? mockFilms : homeViewModel.films) { film in
                    SectorMark(
                        angle: .value("Size",  film.size),
                        innerRadius: .ratio(0.05),
                        angularInset: 1
                    )
                    .foregroundStyle(by: .value("Name", film.nome))
                   
                }
                .chartLegend(position: .leading,
                             alignment: .leading,
                             spacing: 20)
                
                Text("Spazio: \(String.twoDecimal(number: homeViewModel.totalSize)) / \( String.twoDecimal(number: homeViewModel.totalSizeFilm))\nLibero \(String.twoDecimal(number: homeViewModel.totalSize - homeViewModel.totalSizeFilm) ) ")
                    .padding(.top)
               
            }
            
            .frame(width: 800)
            .padding()
        }
        .padding()
    }
   
}

struct SettingsView_Previews: PreviewProvider {
    
    static var previews: some View {
        SettingsView(showAlert: .constant(false))
            .environmentObject(HomeViewModel())
    }
}
