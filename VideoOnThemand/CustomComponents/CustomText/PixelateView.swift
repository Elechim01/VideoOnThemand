//
//  PixelateView.swift
//  VideoOnThemand
//
//  Created by Michele Manniello on 19/10/25.
//

import SwiftUI

struct PixelateView: View {
    private let text: String
    private let font: Font
    private let fontWeight: Font.Weight?
    private let isPixelate: Bool
    private let pixellate: CGFloat
    
    init(text: String,
         font: Font,
         fontWeight: Font.Weight?,
         isPixelate: Bool,
         pixelate: CGFloat = 1 ) {
        
        self.text = text
        self.font = font
        self.fontWeight = fontWeight
        self.isPixelate = isPixelate
        self.pixellate = pixelate
    }
    
    
    var body: some View {
        Text(text)
            .font(font)
            .fontWeight(fontWeight)
            .if(isPixelate, trasform: { view in
                view
                    .distortionEffect(
                        .init(
                            function: .init(library: .default, name: "pixellate"),
                            arguments : [.float(pixellate)]
                        ),
                        maxSampleOffset: .zero)
                    .padding()
                    .background(content: {
                      RoundedRectangle(cornerRadius: 20)
                            .foregroundStyle(.blue)
                    })
 
            })
    }
}


#Preview {
    PixelateView(text: "Michele12", font: .body, fontWeight: .black, isPixelate: true,pixelate: 10)
        .frame(width: 400, height: 400)
        .background(.green)
}
