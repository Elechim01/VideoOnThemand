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
    @Binding  var showAlert: Bool
    @EnvironmentObject var homeViewModel: HomeViewModel
    @FocusState private var showFocus: InfoLabel?
    @State private var pixellate: CGFloat = 20
    private var showOrHide: Bool {
        pixellate == 1 ? true : false
    }
    var body: some View {
        HStack {
            
            VStack(alignment: .leading) {
                CustomText(font: .title2,
                           fontWeight: .bold,
                           text: "Name: \(homeViewModel.localUser.nome)",
                           infoLabel: .name)
                
                CustomText(font: .title3,
                           text: "Surname: \(homeViewModel.localUser.cognome)",
                           infoLabel: .surname)
                
                Divider()
                
                CustomText(font: .system(size: 40),
                           text: "Cell: \(homeViewModel.localUser.cellulare)",
                           infoLabel: .cell)
                
                
                Divider()
                
                CustomText(font: .system(size: 40),
                           text: "Email: \(homeViewModel.localUser.email)",
                           infoLabel: .email)

                CustomText(font: .system(size: 40),
                           text: "Password: \(homeViewModel.localUser.password)",
                           infoLabel: .password,
                           usePixelate: true,
                           pixellate: pixellate)
                
                Button {
                    if pixellate == 1 {
                        pixellate = 20
                    } else {
                        pixellate = 1
                    }
                } label: {
                    Text(showOrHide ? "Hide password" : "Show password")
                }

                Text("Spazio: \(String.twoDecimal(number: homeViewModel.totalSize)) / \( String.twoDecimal(number: homeViewModel.totalSizeFilm))\nLibero \(String.twoDecimal(number: homeViewModel.totalSize - homeViewModel.totalSizeFilm) ) ")
                    .padding(.top)
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
                    .chartLegend(position: .automatic,
                                 alignment: .centerLastTextBaseline,
                                                 spacing: 15)
            }
            
            .frame(width: 800)
            .padding()
        }
        .padding()
        .onAppear {
            print(mockFilms)
        }
    }
 
    
    @ViewBuilder
    func CustomText(font: Font, fontWeight: Font.Weight? = nil, text: String, infoLabel: InfoLabel,usePixelate: Bool = false, pixellate: CGFloat = 1) -> some View {
        if usePixelate {
            Text(text)
                .font(font)
                .fontWeight(fontWeight)
                .frame(height: 60)
                .padding(.vertical)
                .distortionEffect(
                    .init(
                        function: .init(library: .default, name: "pixellate"),
                        arguments : [.float(pixellate)]
                    ),
                    maxSampleOffset: .zero)
            
                .focusable(true)
                .focused($showFocus, equals: infoLabel)
                .background(showFocus == infoLabel ? .green : .clear)
                .clipShape(Capsule())
        } else {
            Text(text)
                .font(font)
                .fontWeight(fontWeight)
                .frame(height: 60)
                .padding(.vertical)
                .focusable(true)
                .focused($showFocus, equals: infoLabel)
                .background(showFocus == infoLabel ? .green : .clear)
                .clipShape(Capsule())
        }
        
    }
    
    enum InfoLabel {
        case name
        case surname
        case cell
        case email
        case password
    }
    
}

struct SettingsView_Previews: PreviewProvider {
    
    static var previews: some View {
        SettingsView(showAlert: .constant(false))
            .environmentObject(HomeViewModel())
    }
}
