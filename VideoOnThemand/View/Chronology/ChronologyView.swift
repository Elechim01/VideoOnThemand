//
//  ChronologyView.swift
//  VideoOnThemand
//
//  Created by Michele Manniello on 25/08/25.
//

import SwiftUI

struct ChronologyView: View {
    @StateObject var chronologyViewModel: ChronologyViewModel
    @State private var selectedFilm: Chronology?
    @Environment(\.isPreview) var isPreview: Bool
    
    let columns = Array(repeating: GridItem(.flexible()), count: 2) // su TV meno colonne ma più grandi

    var body: some View {
        HStack(alignment: .top, spacing: 20) {
            
            // Colonna sinistra con lista film
            ScrollView(.vertical, showsIndicators: false) {
                LazyVGrid(columns: columns, spacing: 10) {
                    ForEach(chronologyViewModel.chronologyList) { item in
                        ChronologyCardView(chronology: item)
                            .frame(width: 400, height: 200)
                            .background(
                                RoundedRectangle(cornerRadius: 15)
                                    .fill(selectedFilm?.id == item.id ? Color.blue.opacity(0.5) : Color.gray.opacity(0.2))
                            )
                            .focusable(true) { isFocused in
                                if isFocused { selectedFilm = item }
                            }
                            .onTapGesture {
                                print("Selezionato film: \(item.filmName)")
                            }
                            .padding()
                           
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
        .ignoresSafeArea()
        .onAppear {
            if isPreview {
                chronologyViewModel.chronologyList = mockChronology
            } else {
                Task {
                    chronologyViewModel.listenerChronology()
                }
            }
        }
    }
}

#Preview {
    ChronologyView(chronologyViewModel: .init(localUser: Utente(
        id: "zglR4HvR0sP3KEqaRGL8Ma5cx5t2",
        nome: "Michele",
        cognome: "Manniello",
        età: 0,
        email: "",
        password: "",
        cellulare: "")
    ))
    .background(Color("Background"))
    .ignoresSafeArea()
}
