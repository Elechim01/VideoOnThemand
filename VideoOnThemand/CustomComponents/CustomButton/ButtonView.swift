//
//  ButtonView.swift
//  VideoOnThemand
//
//  Created by Michele Manniello on 01/11/25.
//

import SwiftUI

struct GlassButtonView: View {
    var text: String
    var action: ()->()
    var body: some View {
        Button {
           action()
        } label: {
            Text(text)
                .frame(maxWidth: .infinity, minHeight: 60)
        }
        .buttonStyle(.automatic)
      //  .background(Color.gray.opacity(0.5))
        .cornerRadius(20)
        .glassEffect(.regular, in: .buttonBorder)
    }
}

#Preview {
    GlassButtonView(text: "Logout", action: {
        
    }).padding()
        .frame(width: 300, height: 400)
        .background(Color("Background"))
}
