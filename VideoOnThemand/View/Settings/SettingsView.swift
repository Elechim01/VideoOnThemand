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
    @State  var showAlert: Bool = false
    @EnvironmentObject var homeViewModel: HomeViewModel
    @EnvironmentObject var loginViewModel: LoginViewModel
    
    @FocusState private var showFocus: InfoLabel?
    @State private var pixellate: CGFloat = 20
    private var showOrHide: Bool { pixellate == 1 }
    
    var body: some View {
        HStack {
            VStack(alignment: .leading) {
                CustomText(font: .title2,
                           fontWeight: .bold,
                           text: "SETTINGS.NAME".localized(homeViewModel.localUser.nome),
                           infoLabel: .name)
                
                CustomText(font: .title3,
                           text:  "SETTINGS.SURNAME".localized(homeViewModel.localUser.cognome),
                           infoLabel: .surname)
                
                Divider()
                
                CustomText(font: .system(size: 40),
                           text: "SETTINGS.CELL".localized(homeViewModel.localUser.cellulare),
                           infoLabel: .cell)
                
                
                Divider()
                
                CustomText(font: .system(size: 40),
                           text: "SETTINGS.EMAIL".localized(homeViewModel.localUser.email),
                           infoLabel: .email)
                
                CustomText(font: .system(size: 40),
                           text: "SETTINGS.PASSWORD".localized(homeViewModel.localUser.password),
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
                    Text(showOrHide ? "SETTINGS.HIDE.PASSWORD".localized() : "SETTINGS.SHOW.PASSWORD".localized())
                }
                
                
                Text("\("SETTINGS.SPACE".localized()) \(formatStorage(homeViewModel.totalSize)) / \(formatStorage(homeViewModel.totalSizeFilm))")
                    .padding()
                    .padding(.top)
                
                Text("\("SETTINGS.FREE".localized()) \(formatStorage(homeViewModel.totalSize - homeViewModel.totalSizeFilm))")
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
                        
                        CustomButton(text: homeViewModel.showGrid ? "SETTINGS.LIST".localized() : "SETTINGS.GRID".localized()) {
                            homeViewModel.showGrid.toggle()
                        }
                        
                        CustomButton(text: "SETTINGS.LOGOUT".localized()) {
                            showAlert.toggle()
                        }
                    }
                    VStack(spacing: 16) {
                        CustomButton(text: homeViewModel.orderAscending ? "SETTINGS.DESCENDENTING".localized() : "SETTINGS.ASCENDENTING".localized()) {
                            homeViewModel.orderAscending.toggle()
                        }
                    }
                }
                .frame(width: 800)
                .padding()
                
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
        .alert("HOME.ALERT.LOGOUT.TITLE".localized(), isPresented: $showAlert) {
            Button("HOME.ALERT.LOGOUT.CANCEL".localized(),role: .cancel){
                showAlert = false
            }
            
            Button("HOME.ALERT.LOGOUT.CONFIRM",role: .destructive){
                homeViewModel.stream?.remove()
                loginViewModel.logOut()
                showAlert.toggle()
                
            }
        }
        .onAppear {
#if DEBUG
            print(mockFilms)
#endif
        }
    }
 
    @ViewBuilder
    private func CustomText(font: Font, fontWeight: Font.Weight? = nil, text: String, infoLabel: InfoLabel,usePixelate: Bool = false, pixellate: CGFloat = 1) -> some View {
        
        Text(text)
            .font(font)
            .fontWeight(fontWeight)
            .frame(height: 60)
            .modifier(CustomButtonModifier(isFocused: showFocus == infoLabel))
            .if(usePixelate, trasform: { view in
                view
                    .distortionEffect(
                        .init(
                            function: .init(library: .default, name: "pixellate"),
                            arguments : [.float(pixellate)]
                        ),
                        maxSampleOffset: .zero)
            })
            .focusable(true)
            .focused($showFocus, equals: infoLabel)
            .padding(.horizontal)
            
        
    }
    
    @ViewBuilder
    private func CustomButton(text: String, action: @escaping ()->()) -> some View {
        Button {
           action()
        } label: {
            Text(text)
                .frame(maxWidth: .infinity, minHeight: 60)
        }
        .buttonStyle(.plain)
        .background(Color.gray.opacity(0.5))
        .cornerRadius(13)
    }
    
    enum InfoLabel {
        case name
        case surname
        case cell
        case email
        case password
    }
    
    private struct CustomButtonModifier: ViewModifier {
        var isFocused: Bool
        
        func body(content: Content) -> some View {
            content
              //  .padding(.vertical, isFocused ? 20 : 10)
                .padding(.horizontal, isFocused ? 20: 10)
                .background(isFocused ? Color("Green").opacity(0.9) : .clear)
                .clipShape(Capsule())
            
                .padding(.horizontal, isFocused ? 0 : 0)
               /* .background(
                    Capsule()
                        .stroke(isFocused ? Color.white : Color.clear, lineWidth: 4)
                )
                */
            
        }
    }
    
    private func formatStorage(_ mb: Double) -> String {
        guard mb > 1024 else {
            return String.twoDecimalMB(number: mb)
        }
        let gb = mb/1024
        
        return String.twoDecimalGB(number: gb)
    }
    
}


struct SettingsView_Previews: PreviewProvider {
    
    static var previews: some View {
       SettingsView()
            .environmentObject(LoginViewModel())
            .environmentObject(HomeViewModel())
            .background(Color("T1"))
        
    }
}
 
