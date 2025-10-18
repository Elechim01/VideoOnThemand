//
//  ViewExt.swift
//  VideoOnThemand
//
//  Created by Michele Manniello on 16/08/25.
//

import SwiftUI

extension View {
    
    @ViewBuilder
    func `if`<Content: View>(_ condition: Bool, trasform:(Self) ->Content ) -> some View{
        if condition {
            trasform(self)
        } else {
            self
        }
    }
    
    func snapshot() -> UIImage {
        let controller = UIHostingController(rootView: self)
        let view = controller.view
        let size = controller.sizeThatFits(in: UIScreen.main.bounds.size)
        view?.bounds = CGRect(origin: .zero, size: size)
        view?.backgroundColor = .clear
        
        let renderer = UIGraphicsImageRenderer(size: size)
        return renderer.image { _ in
            view?.drawHierarchy(in: view?.bounds ?? CGRect.zero, afterScreenUpdates: true)
        }
    }
}


