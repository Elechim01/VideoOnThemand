//
//  PageManager.swift
//  VideoOnThemand
//
//  Created by Michele Manniello on 26/08/25.
//

import SwiftUI

struct PageManager: View {
    @State private var page: SectionPages
    @EnvironmentObject var loginViewModel: LoginViewModel
    @EnvironmentObject var homeviewModel: HomeViewModel
    @Namespace private var focusNamespace
    
    init(page: SectionPages = .video) {
        _page = State(initialValue: page)
    }
    
    var body: some View {
        NavigationView {
            VStack(alignment: .leading, spacing: 16) {
                HStack {
                    Spacer()
                    Picker("HOME.PAGE.PICKER".localized(), selection: $page) {
                        Text("HOME.PAGE.VIDEO".localized()).tag(SectionPages.video)
                        Text("HOME.PAGE.IMPOSTAZIONI".localized()).tag(SectionPages.impostazioni)
                        Text("HOME.PAGE.CRONOLOGIA".localized()).tag(SectionPages.cronologia)
                    }
                    .background(Color.black)
                    .clipShape(Capsule())
                    Spacer()
                }
                .padding(.vertical)
                
                Group {
                    switch page {
                    case .video:
                       HomeView()
                            .environmentObject(homeviewModel)
                            .environmentObject(loginViewModel)
                    case .impostazioni:
                        SettingsView()
                            .environmentObject(homeviewModel)
                            .environmentObject(loginViewModel)
                    case .cronologia:
                        ChronologyView(chronologyViewModel: ChronologyViewModel(localUser: homeviewModel.localUser))
                    }
                }
            }
            .padding()
        }
        .background(Color("Background").ignoresSafeArea())
        .focusScope(focusNamespace)
    }
    
    enum SectionPages {
        case video
        case impostazioni
        case cronologia
    }
}

#Preview {
    Group {
        PageManager(page: .video)
           
        PageManager(page: .impostazioni)
          
        PageManager(page: .cronologia)
            
    }
    .environmentObject(LoginViewModel())
    .environmentObject(HomeViewModel())
   
}
