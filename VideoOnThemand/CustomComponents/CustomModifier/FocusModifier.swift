//
//  FocusModifier.swift
//  VideoOnThemand
//
//  Created by Michele Manniello on 19/10/25.
//

import SwiftUI

struct FocusModifier<Value>: ViewModifier where Value: Hashable {
    var isFocused: Bool
    var focused: FocusState<Value>.Binding
    var equals: Value
    
    func body(content: Content) -> some View {
        content
            .focusable(true)
           // .focused($showFocus, equals: infoLabel)
            .focused(focused, equals: equals)
            .padding(.horizontal, isFocused ? 20: 10)
            .background(isFocused ? Color("Green").opacity(0.9) : .clear)
            .clipShape(Capsule())
            .padding(.horizontal, isFocused ? 0 : 0)
        
    }
}

#Preview {
    BubbleText(descriptionText: "Title",text: "Test", font: .body)
       // .modifier(FocusModifier(isFocused: false, focused: , equals: <#T##Value#>))
    
}
