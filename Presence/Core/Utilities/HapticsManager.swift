//
//  HapticsManager.swift
//  Presence
//
//  Central manager for triggering tactile haptic feedback.
//  Enhances the premium feel of interactions in Presence.
//

import UIKit

/// Central utility for triggering haptic feedback.
public final class HapticsManager {
    
    public static let shared = HapticsManager()
    
    private let selectionGenerator = UISelectionFeedbackGenerator()
    private let impactGeneratorLight = UIImpactFeedbackGenerator(style: .light)
    private let impactGeneratorMedium = UIImpactFeedbackGenerator(style: .medium)
    private let notificationGenerator = UINotificationFeedbackGenerator()
    
    private init() {
        // Pre-prepare generators for lower latency
        selectionGenerator.prepare()
        impactGeneratorLight.prepare()
        impactGeneratorMedium.prepare()
        notificationGenerator.prepare()
    }
    
    // MARK: - Feedback Methods
    
    /// Triggered for subtle changes (e.g. tab selection, list scrolling).
    public func selection() {
        selectionGenerator.selectionChanged()
        selectionGenerator.prepare()
    }
    
    /// A soft, subtle tap for interactive elements like cards.
    public func impactLight() {
        impactGeneratorLight.impactOccurred()
        impactGeneratorLight.prepare()
    }
    
    /// A more pronounced tap for primary actions.
    public func impactMedium() {
        impactGeneratorMedium.impactOccurred()
        impactGeneratorMedium.prepare()
    }
    
    /// Feedback for successful operations (e.g. saved reflection).
    public func success() {
        notificationGenerator.notificationOccurred(.success)
        notificationGenerator.prepare()
    }
    
    /// Feedback for failed operations.
    public func error() {
        notificationGenerator.notificationOccurred(.error)
        notificationGenerator.prepare()
    }
    
    /// Feedback for warnings.
    public func warning() {
        notificationGenerator.notificationOccurred(.warning)
        notificationGenerator.prepare()
    }
}
