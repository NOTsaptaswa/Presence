//
//  InteractiveButtonStyle.swift
//  Presence
//
//  Premium interactive button styles for the Presence animation system.
//  Provides tactile press feedback with scale, opacity, and spring motion.
//

import SwiftUI

// MARK: - Press Scale Button Style

/// A button style that scales down subtly on press with a spring animation.
/// Feels responsive and premium — like pressing a physical key.
struct PressScaleButtonStyle: ButtonStyle {
    
    let scale: CGFloat
    let opacity: CGFloat
    
    init(
        scale: CGFloat = MotionTokens.pressScale,
        opacity: CGFloat = 0.85
    ) {
        self.scale = scale
        self.opacity = opacity
    }
    
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .scaleEffect(configuration.isPressed ? scale : 1)
            .opacity(configuration.isPressed ? opacity : 1)
            .animation(MotionTokens.snappySpring, value: configuration.isPressed)
            .onChange(of: configuration.isPressed) { _, newValue in
                if newValue { HapticsManager.shared.impactLight() }
            }
    }
}

// MARK: - Soft Press Button Style

/// A gentler press style with minimal scale and a slow spring.
/// Ideal for larger cards or hero elements.
struct SoftPressButtonStyle: ButtonStyle {
    
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .scaleEffect(configuration.isPressed ? MotionTokens.highlightScale : 1)
            .opacity(configuration.isPressed ? 0.9 : 1)
            .animation(MotionTokens.gentleSpring, value: configuration.isPressed)
    }
}

// MARK: - Bounce Button Style

/// A spring-based press style with a slightly more pronounced bounce.
/// Best for primary action buttons where tactile feedback matters.
struct BounceButtonStyle: ButtonStyle {
    
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .scaleEffect(configuration.isPressed ? 0.93 : 1)
            .opacity(configuration.isPressed ? 0.8 : 1)
            .animation(
                .spring(response: 0.25, dampingFraction: 0.6),
                value: configuration.isPressed
            )
            .onChange(of: configuration.isPressed) { _, newValue in
                if newValue { HapticsManager.shared.impactMedium() }
            }
    }
}

// MARK: - Glow Press Button Style

/// Combines a press scale with a subtle background brightness shift.
/// Ideal for buttons with translucent backgrounds.
struct GlowPressButtonStyle: ButtonStyle {
    
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .scaleEffect(configuration.isPressed ? MotionTokens.pressScale : 1)
            .brightness(configuration.isPressed ? 0.05 : 0)
            .animation(MotionTokens.snappySpring, value: configuration.isPressed)
            .onChange(of: configuration.isPressed) { _, newValue in
                if newValue { HapticsManager.shared.impactLight() }
            }
    }
}

// MARK: - View Extensions

extension View {
    
    /// Applies the standard press-scale button feedback.
    func pressableStyle(
        scale: CGFloat = MotionTokens.pressScale,
        opacity: CGFloat = 0.85
    ) -> some View {
        self.buttonStyle(
            PressScaleButtonStyle(scale: scale, opacity: opacity)
        )
    }
    
    /// Applies a soft, gentle press style for larger surfaces.
    func softPressStyle() -> some View {
        self.buttonStyle(SoftPressButtonStyle())
    }
    
    /// Applies a bounce press style for primary actions.
    func bounceStyle() -> some View {
        self.buttonStyle(BounceButtonStyle())
    }
    
    /// Applies a glow-on-press style for translucent buttons.
    func glowPressStyle() -> some View {
        self.buttonStyle(GlowPressButtonStyle())
    }
}
