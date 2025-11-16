//
//  BubbleText.swift
//  VideoOnThemand
//
//  Created by Michele Manniello on 19/10/25.
//

import SwiftUI

struct BubbleText: View {
    
    private let textLeft: String
    private let text: String
    private let font: Font

    
    init(descriptionText: String,text: String, font: Font) {
        self.textLeft = descriptionText
        self.font = font
        self.text = text
    }
    
//    var isfocused: FocusState
    var body: some View {
        DoubleText(textLeft: textLeft,
                   rightText: text,
                   fontTextLeft: font,
                   fontTextRight: font)
        
    }
}

#Preview {
    BubbleText(descriptionText: "Title", text: "Test", font: .body)
        .frame(width: 300, height: 400)
        .background(Color("Background"))
}
