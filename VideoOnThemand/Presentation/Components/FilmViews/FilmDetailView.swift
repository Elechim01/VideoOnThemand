//
//  FilmDetailView.swift
//  VideoOnThemand
//
//  Created by Michele Manniello on 01/11/25.
//

import SwiftUI
import ElechimCore

struct FilmDetailView: View {
    let chronology: Chronology
    
    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            
            DoubleText(textLeft: "CHRONOLOGY.TITLE".localized(),
                       rightText: chronology.filmName,
                       fontTextLeft: .title2.bold(),
                       fontTextRight: .system(size: 40).bold())
            
            
            DoubleText(textLeft: "CHRONOLOGY.DATE".localized(),
                       rightText: Utils.formatFullDate(chronology.date),
                       fontTextLeft: .headline.bold(),
                       fontTextRight: .headline)
            
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding()
        .background(Color.gray.opacity(0.1))
        .cornerRadius(12)
        .glassEffectTransition(.materialize)
        .ignoresSafeArea()
        
    }
}

#Preview {
    FilmDetailView(chronology: .init(film: mockFilms[0], localUsedId: "Michele"))
        .background(Color("Background"))
        .padding()
        .frame(width: 1000, height: 400)
}
