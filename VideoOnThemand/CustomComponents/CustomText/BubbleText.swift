//
//  BubbleText.swift
//  VideoOnThemand
//
//  Created by Michele Manniello on 19/10/25.
//

import SwiftUI

struct BubbleText: View {
    
    private let text: String
    private let font: Font
    private let fontWeight: Font.Weight?

    
    init( text: String, font: Font, fontWeight: Font.Weight?) {
        self.font = font
        self.fontWeight = fontWeight
        self.text = text
    }
    
//    var isfocused: FocusState
    var body: some View {
        Text(text)
            .font(font)
            .fontWeight(fontWeight)
            .padding()
            .glassEffect(.regular, in: .capsule)
        
    }
}

#Preview {
    BubbleText(text: "Test", font: .body, fontWeight: .bold)
        .frame(width: 300, height: 400)
        .background(.green)
}
/*
 @ViewBuilder
 private func CustomText(font: Font, fontWeight: Font.Weight? = nil, text: String, infoLabel: InfoLabel,usePixelate: Bool = false, pixellate: CGFloat = 1) -> some View {
 
 Text(text)

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
 .if(!usePixelate, trasform: { view in
 view
 
 })
 }
 */

