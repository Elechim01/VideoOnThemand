//
//  ChronologyCardView.swift
//  VideoOnThemand
//
//  Created by Michele Manniello on 01/11/25.
//

import SwiftUI

struct ChronologyCardView: View {
    let chronology: Chronology
    var body: some View {
        VStack {
            Rectangle()
                .fill(Color.black.opacity(0.2))
                .overlay(
                    Text(chronology.filmName)
                        .font(.title3)
                        .bold()
                        .multilineTextAlignment(.center)
                        .padding()
                )
                .cornerRadius(12)
                .glassEffect(.regular,in: .rect)
        }
    }
}

#Preview {
    ChronologyCardView(chronology: .init(film: mockFilms[0], localUsedId: ""))
        .frame(width: 400,height: 200)
        .background(Color("Background"))
}
