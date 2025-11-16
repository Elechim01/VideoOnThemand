//
//  Colors.swift
//  VideoOnThemand
//
//  Created by Michele Manniello on 16/11/25.
//

import SwiftUI

/// Centralised colour‑gradient definitions for the app.
struct AppColors {

    // MARK: - Light theme gradient
    private static var lightGradient: LinearGradient {
        LinearGradient(
            gradient: Gradient(stops: [
                .init(color: Color(red: 0.20, green: 0.85, blue: 0.45), location: 0.0),   // Mint‑green start
                .init(color: Color(red: 0.15, green: 0.78, blue: 0.55), location: 0.30), // Soft transition to teal
                .init(color: Color(red: 0.10, green: 0.70, blue: 0.68), location: 0.55), // Mid‑tone teal‑blue
                .init(color: Color(red: 0.07, green: 0.55, blue: 0.85), location: 0.80), // Deepening to true blue
                .init(color: Color(red: 0.04, green: 0.35, blue: 0.95), location: 1.0)   // Final ocean‑blue
            ]),
            startPoint: .topLeading,
            endPoint: .bottomTrailing
        )
    }

    // MARK: - Dark theme gradient
    private static var darkGradient: LinearGradient {
        LinearGradient(
            gradient: Gradient(stops: [
                .init(color: Color(red: 0.05, green: 0.20, blue: 0.15), location: 0.0),   // Very deep teal
                .init(color: Color(red: 0.07, green: 0.25, blue: 0.22), location: 0.30), // Darker transition
                .init(color: Color(red: 0.09, green: 0.30, blue: 0.30), location: 0.55), // Mid‑tone dark teal
                .init(color: Color(red: 0.10, green: 0.35, blue: 0.45), location: 0.80), // Slightly lighter but still dark
                .init(color: Color(red: 0.12, green: 0.45, blue: 0.55), location: 1.0)    // End of dark gradient
            ]),
            startPoint: .topLeading,
            endPoint: .bottomTrailing
        )
    }

    // MARK: - Public accessor
    /// Returns the appropriate background gradient for the supplied colour scheme.
    static func backgroundGradient(for colorScheme: ColorScheme) -> LinearGradient {
        colorScheme == .dark ? darkGradient : lightGradient
    }
}
