//
//  SettingsView.swift
//  VideoOnThemand
//
//  Created by Michele Manniello on 10/08/22.
//

import SwiftUI
import Charts
import Services
import ElechimCore

struct SettingsView: View {
    
    @Environment(\.isPreview) var isPreviews
    @State  var showAlert: Bool = false
    @EnvironmentObject var homeViewModel: HomeViewModel
    @EnvironmentObject var coordinator: Coordinator
    
    @FocusState private var showFocus: InfoLabel?
    private let pixellate: CGFloat = 20
    @State private var usePixelate: Bool = true
    private var showOrHide: Bool { pixellate == 1 }
    
    
    
    var body: some View {
        HStack {
            VStack(alignment: .leading) {
                CustomText(font: .title2,
                           fontWeight: .bold,
                           text: homeViewModel.sessionManager.currentUser?.nome ?? "",
                           infoLabel: .name)
                
                CustomText(font: .title3,
                           text:  homeViewModel.sessionManager.currentUser?.cognome ?? "",
                           infoLabel: .surname)
                
                Divider()
                
                CustomText(font: .system(size: 40),
                           text: homeViewModel.sessionManager.currentUser?.cellulare ?? "",
                           infoLabel: .cell)
                
                
                Divider()
                
                CustomText(font: .system(size: 40),
                           text: homeViewModel.sessionManager.currentUser?.email ?? "",
                           infoLabel: .email)
                
                
                if(usePixelate) {
                    PixelateView(text:  homeViewModel.sessionManager.currentUser?.password ?? "", font: .system(size: 40), fontWeight: nil, pixelate: pixellate)
                } else {
                    CustomText(font: .system(size: 40),
                               text: homeViewModel.sessionManager.currentUser?.password ?? "",
                               infoLabel: .password)
                }
                
                
                Button {
                    usePixelate.toggle()
                } label: {
                    Text(showOrHide ? "SETTINGS.HIDE.PASSWORD".localized() : "SETTINGS.SHOW.PASSWORD".localized())
                }
                
                
                Text("\("SETTINGS.SPACE".localized()) \(Utils.formatStorage(homeViewModel.totalSize)) / \(Utils.formatStorage (homeViewModel.totalSizeFilm))")
                    .padding()
                    .padding(.top)
                
                Text("\("SETTINGS.FREE".localized()) \(Utils.formatStorage(homeViewModel.totalSize - homeViewModel.totalSizeFilm))")
                    .padding()
                    .padding(.top)
            }
            
            Spacer()
            VStack {
                
                VStack(alignment: .leading, spacing: 24) {
                    // Header sezione
                    Text("SETTINGS.SECTION.USER".localized())
                        .font(.headline)
                        .padding(.leading, 8)
                    
                    VStack(spacing: 16) {
                        
                        GlassButtonView(text: homeViewModel.showGrid ? "SETTINGS.LIST".localized() : "SETTINGS.GRID".localized()) {
                            homeViewModel.showGrid.toggle()
                        }
                        
                        GlassButtonView(text: "SETTINGS.LOGOUT".localized()) {
                            showAlert.toggle()
                        }
                    }
                    VStack(spacing: 16) {
                        GlassButtonView(text: homeViewModel.orderAscending ? "SETTINGS.DESCENDENTING".localized() : "SETTINGS.ASCENDENTING".localized()) {
                            homeViewModel.orderAscending.toggle()
                        }
                    }
                }
                .frame(width: 800)
                .padding()
                
                Chart(isPreviews ? Mock.mockFilm : homeViewModel.films) { film in
                    
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
        .alert("HOME.ALERT.LOGOUT.TITLE".localized(), isPresented: $showAlert) {
            Button("HOME.ALERT.LOGOUT.CANCEL".localized(),role: .cancel){
                showAlert = false
            }
            Button("HOME.ALERT.LOGOUT.CONFIRM",role: .destructive){
                coordinator.logout()
                showAlert.toggle()
            }
        }
    }
    
    @ViewBuilder
    private func CustomText(font: Font, fontWeight: Font.Weight? = nil, text: String, infoLabel: InfoLabel) -> some View {
        BubbleText(descriptionText: infoLabel.value, text: text, font: font)
            .modifier(FocusModifier(isFocused: showFocus == infoLabel,
                                    focused: $showFocus,
                                    equals: infoLabel))
    }
    
    enum InfoLabel {
        case name
        case surname
        case cell
        case email
        case password
        
        var value: String {
            switch self {
            case .name:
                return "SETTINGS.NAME".localized()
            case .surname:
                return "SETTINGS.SURNAME".localized()
            case .cell:
                return "SETTINGS.CELL".localized()
            case .email:
                return  "SETTINGS.EMAIL".localized()
            case .password:
                return "SETTINGS.PASSWORD".localized()
            }
        }
        
    }
    
}


struct SettingsView_Previews: PreviewProvider {
    
    static var previews: some View {
        SettingsView()
            .environmentObject(Coordinator())
            .environmentObject( Coordinator().homeViewModel)
            .background(Color("Background"))
        
    }
}

