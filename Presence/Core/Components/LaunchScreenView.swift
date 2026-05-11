//
//  LaunchScreenView.swift
//  Presence
//
//  A calm, immersive launch screen for Presence.
//  Bridges the gap between the system boot and the app content.
//

import SwiftUI

public struct LaunchScreenView: View {
    @State private var isAnimating = false
    @State private var showTitle = false
    
    public init() {}
    
    public var body: some View {
        ZStack {
            // Immersive background that starts animating immediately
            AmbientBackgroundView()
            
            VStack(spacing: 24) {
                // Minimalist Glyph (Matches the App Icon theme)
                Image(systemName: "circle.circle")
                    .font(.system(size: 60, weight: .thin))
                    .foregroundStyle(.primary)
                    .scaleEffect(isAnimating ? 1.0 : 0.9)
                    .opacity(showTitle ? 1 : 0)
                
                Text("Presence")
                    .font(.system(size: 34, weight: .thin, design: .rounded))
                    .foregroundStyle(.primary)
                    .tracking(8.0) // Wide tracking for a premium, airy feel
                    .offset(y: showTitle ? 0 : 10)
                    .opacity(showTitle ? 1 : 0)
            }
        }
        .onAppear {
            // Start the sequence
            withAnimation(.easeOut(duration: 1.2).delay(0.2)) {
                showTitle = true
            }
            
            withAnimation(.easeInOut(duration: 2.5).repeatForever(autoreverses: true)) {
                isAnimating = true
            }
        }
    }
}

// MARK: - Preview

#Preview {
    LaunchScreenView()
        .preferredColorScheme(.dark)
}
