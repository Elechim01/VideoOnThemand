//
//  DoubleText.swift
//  VideoOnThemand
//
//  Created by Michele Manniello on 01/11/25.
//

import SwiftUI

struct DoubleText: View {
    let textLeft: String
    let rightText: String
    let fontTextLeft: Font
    let fontTextRight: Font
    
    
    var body: some View {
        HStack(spacing: 10) {
            Text(textLeft)
                .font(fontTextLeft)
                .padding(.vertical)
                .padding(.horizontal)
                .glassEffect(.regular,in: .capsule)
            
            Text(rightText)
                .font(fontTextRight)
                .padding()
                .padding(.horizontal)
                .glassEffect(.regular,in: .capsule)
            
        }
    }
}

#Preview {
    DoubleText(textLeft: "SINISTRA", rightText: "DESTRA", fontTextLeft: .title.bold(), fontTextRight: .title3.bold())
        .padding()
        .background(Color("Background"))
}
