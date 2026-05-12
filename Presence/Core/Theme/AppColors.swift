//
//  AppColors.swift
//  Presence
//
//  Dynamic color tokens for Presence.
//  Uses system adaptive colors to support both Light and Dark mode.
//

import SwiftUI

enum AppColors {
    
    /// The primary background color (Adaptive)
    static let background = Color(uiColor: .systemBackground)
    
    /// Semi-transparent card background that works on both themes
    static let cardBackground = Color.primary.opacity(0.08)
    
    /// Adaptive secondary text
    static let secondaryText = Color.secondary
    
    /// Primary accent color
    static let accent = Color.primary
}