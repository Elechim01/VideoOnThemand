//
//  ChronologyView.swift
//  VideoOnThemand
//
//  Created by Michele Manniello on 25/08/25.
//

import SwiftUI
import Services

struct ChronologyView: View {
    @EnvironmentObject var chronologyViewModel: ChronologyViewModel
    @State private var selectedFilm: Chronology?
    @Environment(\.isPreview) var isPreview: Bool
    
    let columns = Array(repeating: GridItem(.flexible()), count: 2) // su TV meno colonne ma più grandi
    
    var body: some View {
        ZStack {
            HStack(alignment: .top, spacing: 20) {
                
                // Colonna sinistra con lista film
                ScrollView(.vertical, showsIndicators: false) {
                    LazyVGrid(columns: columns, spacing: 10) {
                        ForEach(chronologyViewModel.chronologyList) { item in
                            ChronologyCardView(chronology: item)
                                .frame(width: 400, height: 200)
                                .background(
                                    RoundedRectangle(cornerRadius: 15)
                                        .fill(selectedFilm?.id == item.id ? Color.blue.opacity(0.3) : Color.gray.opacity(0.1))
                                        .overlay(
                                            RoundedRectangle(cornerRadius: 15)
                                                .stroke(selectedFilm?.id == item.id ? Color.blue : Color.clear, lineWidth: 3)
                                        )
                                )
                                .scaleEffect(selectedFilm?.id == item.id ? 1.05 : 1.0) // Zoom sulla selezione
                                .animation(.spring(response: 0.3, dampingFraction: 0.6), value: selectedFilm?.id)
                                .onTapGesture {
                                    withAnimation { selectedFilm = item }
                                }
                                .focusable(true) { isFocused in
                                    if isFocused {
                                        withAnimation { selectedFilm = item }
                                    }
                                }
                            
                        }
                        
                    }
                    .padding()
                }
                
                // Pannello di destra con i dettagli
                if let film = selectedFilm {
                    FilmDetailView(chronology: film)
                        .transition(.move(edge: .trailing).combined(with: .opacity))
                } else {
                    VStack {
                        Text("Seleziona un film 🎬")
                            .foregroundStyle(.secondary)
                            .font(.title2)
                            .padding()
                            .glassEffect(.regular,in: .capsule)
                    }
                }
            }
            
            if chronologyViewModel.isLoading {
                CustomProgressView()
            }
        }
        .ignoresSafeArea()
        .onAppear {
            if isPreview {
                chronologyViewModel.chronologyList = Mock.mockChronology
                
            } else {
                Task {
                    await chronologyViewModel.loadChronology()
                }
            }
        }
    }
}

#Preview {
    ChronologyView()
        .frame(width: .infinity, height: .infinity)
        .environmentObject(Coordinator().chronologyViewModel)
        .background(Color("Background"))
        .ignoresSafeArea()
}
