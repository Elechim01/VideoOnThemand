//
//  CustomProgressView.swift
//  VideoOnThemand
//
//  Created by Michele Manniello on 01/04/26.
//

import SwiftUI

struct CustomProgressView: View {
    var body: some View {
        ZStack {            
            VStack(spacing: 20) {
                ProgressView()
                    .controlSize(.large)
                    .tint(.white)
                
                Text("Caricamento in corso...")
                    .foregroundStyle(.white)
                    .font(.headline)
            }
            .padding(40)
            .background(.thickMaterial, in: RoundedRectangle(cornerRadius: 20))
        }
    }
}
#Preview {
    CustomProgressView()
}

