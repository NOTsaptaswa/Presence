//
//  MotionTokens.swift
//  Presence
//
//  Motion design tokens for the Presence animation system.
//  Centralizes all spring, duration, and easing values.
//

import SwiftUI

// MARK: - Motion Design Tokens

/// Centralized motion constants for the Presence animation system.
/// Use these tokens instead of inline animation values for consistency.
enum MotionTokens {
    
    // MARK: - Spring Presets
    
    /// Gentle spring for ambient, background-level motion.
    /// Response: 0.7s, dampingFraction: 0.8 — slow and calm.
    static let gentleSpring = Animation.spring(
        response: 0.7,
        dampingFraction: 0.8,
        blendDuration: 0.1
    )
    
    /// Standard interactive spring for most UI transitions.
    /// Response: 0.5s, dampingFraction: 0.78 — balanced and responsive.
    static let standardSpring = Animation.spring(
        response: 0.5,
        dampingFraction: 0.78,
        blendDuration: 0.05
    )
    
    /// Snappy spring for button presses and quick feedback.
    /// Response: 0.3s, dampingFraction: 0.7 — fast with subtle bounce.
    static let snappySpring = Animation.spring(
        response: 0.3,
        dampingFraction: 0.7,
        blendDuration: 0.0
    )
    
    /// Soft landing spring for floating card entrances.
    /// Response: 0.6s, dampingFraction: 0.82 — smooth arrival.
    static let floatingSpring = Animation.spring(
        response: 0.6,
        dampingFraction: 0.82,
        blendDuration: 0.1
    )
    
    // MARK: - Durations
    
    /// Quick transition (opacity flickers, state changes).
    static let durationFast: Double = 0.2
    
    /// Standard transition (card appearances, tab switches).
    static let durationMedium: Double = 0.35
    
    /// Slow transition (page-level, onboarding-style reveals).
    static let durationSlow: Double = 0.55
    
    // MARK: - Easing Curves
    
    /// Ease-out for elements entering the screen.
    static let easeOut = Animation.easeOut(duration: durationMedium)
    
    /// Ease-in-out for symmetric transitions.
    static let easeInOut = Animation.easeInOut(duration: durationMedium)
    
    // MARK: - Offsets
    
    /// Vertical offset for floating card entrance.
    static let floatingCardOffset: CGFloat = 24
    
    /// Vertical offset for subtle slide-up reveals.
    static let slideUpOffset: CGFloat = 16
    
    /// Scale for press-down button feedback.
    static let pressScale: CGFloat = 0.96
    
    /// Scale for subtle hover/highlight.
    static let highlightScale: CGFloat = 0.98
}
