//
//  PageManager.swift
//  VideoOnThemand
//
//  Created by Michele Manniello on 26/08/25.
//

import SwiftUI

struct PageManager: View {
    @State private var page: SectionPages = .video
    @ObservedObject var homeviewModel: HomeViewModel
    @ObservedObject var chronologyViewModel: ChronologyViewModel
    @EnvironmentObject var coordinator: Coordinator
    @Namespace private var focusNamespace
    @Environment(\.colorScheme) var colorScheme
    
    init(page: SectionPages = .video, homeViewModel: HomeViewModel,
         chronologyViewModel: ChronologyViewModel ) {
        _page = State(initialValue: page)
        self.homeviewModel = homeViewModel
        self.chronologyViewModel = chronologyViewModel
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
                    case .impostazioni:
                        SettingsView()
                            .environmentObject(homeviewModel)
                            .environmentObject(coordinator)
                    case .cronologia:
                        ChronologyView()
                            .environmentObject(chronologyViewModel)
                    }
                }
            }
            .padding()
        }
        .environmentObject(coordinator)
        .background(AppColors.backgroundGradient(for:colorScheme).ignoresSafeArea())
        .focusScope(focusNamespace)
    }
}

#Preview {
    Group {
        PageManager(page: .video,
                    homeViewModel: Coordinator().homeViewModel,
                    chronologyViewModel: Coordinator().chronologyViewModel )
        
        PageManager(page: .impostazioni,
                    homeViewModel: Coordinator().homeViewModel,
                    chronologyViewModel: Coordinator().chronologyViewModel )
        
        PageManager(page: .cronologia,
                    homeViewModel: Coordinator().homeViewModel,
                    chronologyViewModel: Coordinator().chronologyViewModel )
        
    }
    .environmentObject(Coordinator())
    
}
