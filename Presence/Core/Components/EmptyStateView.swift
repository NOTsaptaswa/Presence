//
//  EmptyStateView.swift
//  Presence
//
//  Reusable, premium Apple-style empty state component.
//  Designed for minimal, calm interactions in Presence.
//

import SwiftUI

/// A reusable component for displaying empty states across the app.
/// Follows Apple's "Health" and "Journal" design language.
public struct EmptyStateView: View {
    
    let systemImage: String
    let title: String
    let subtitle: String
    let actionTitle: String?
    let action: (() -> Void)?
    
    public init(
        systemImage: String,
        title: String,
        subtitle: String,
        actionTitle: String? = nil,
        action: (() -> Void)? = nil
    ) {
        self.systemImage = systemImage
        self.title = title
        self.subtitle = subtitle
        self.actionTitle = actionTitle
        self.action = action
    }
    
    public var body: some View {
        VStack(spacing: 24) {
            
            // MARK: - Icon
            // Using a thin weight for that premium, modern iOS look
            Image(systemName: systemImage)
                .font(.system(size: 72, weight: .thin))
                .foregroundStyle(AppColors.secondaryText)
                .appearAnimation(delay: 0.1, from: .up, distance: 12)
            
            // MARK: - Text Content
            VStack(spacing: 12) {
                Text(title)
                    .font(.system(size: 22, weight: .bold, design: .rounded))
                    .foregroundStyle(.primary)
                    .multilineTextAlignment(.center)
                    .appearAnimation(delay: 0.2, from: .up, distance: 10)
                
                Text(subtitle)
                    .font(Typography.subheadline)
                    .foregroundStyle(AppColors.secondaryText)
                    .multilineTextAlignment(.center)
                    .lineSpacing(4)
                    .padding(.horizontal, 40)
                    .appearAnimation(delay: 0.3, from: .up, distance: 8)
            }
            
            // MARK: - Action Button
            if let actionTitle = actionTitle, let action = action {
                Button(action: action) {
                    Text(actionTitle)
                        .font(.system(size: 15, weight: .semibold, design: .rounded))
                        .foregroundStyle(.black)
                        .padding(.horizontal, 24)
                        .padding(.vertical, 12)
                        .background(Color.white)
                        .clipShape(Capsule())
                }
                .pressableStyle()
                .appearAnimation(delay: 0.4, from: .up, distance: 6)
                .padding(.top, 8)
            }
        }
        .padding(32)
        .frame(maxWidth: .infinity, maxHeight: .infinity)
    }
}

// MARK: - Specific State Presets

extension EmptyStateView {
    
    /// State for when no HealthKit data is available.
    static func noHealthData() -> EmptyStateView {
        EmptyStateView(
            systemImage: "heart.text.square",
            title: "No Health Data",
            subtitle: "We couldn't find any recent health activity. Ensure your Apple Watch or iPhone is tracking data."
        )
    }
    
    /// State for when analytics are still processing.
    static func noAnalytics() -> EmptyStateView {
        EmptyStateView(
            systemImage: "waveform.path.ecg",
            title: "Analyzing Patterns",
            subtitle: "Presence is currently analyzing your behavioral trends. This usually takes a few hours of data collection."
        )
    }
    
    /// State for when the user hasn't recorded any reflections.
    static func noReflections(onStart: @escaping () -> Void) -> EmptyStateView {
        EmptyStateView(
            systemImage: "pencil.and.outline",
            title: "Begin Your Journey",
            subtitle: "Start tracking your mental clarity and focus by recording your first daily reflection.",
            actionTitle: "New Reflection",
            action: onStart
        )
    }
    
    /// State for when HealthKit permissions are denied.
    static func permissionsDisabled() -> EmptyStateView {
        EmptyStateView(
            systemImage: "lock.shield",
            title: "Permissions Required",
            subtitle: "To track your recovery and focus, Presence needs access to your Health data.",
            actionTitle: "Open Settings",
            action: {
                if let url = URL(string: UIApplication.openSettingsURLString) {
                    UIApplication.shared.open(url)
                }
            }
        )
    }
}

// MARK: - Previews

#Preview("No Reflections") {
    ZStack {
        AmbientBackgroundView()
        EmptyStateView.noReflections {}
    }
    .preferredColorScheme(.dark)
}

#Preview("Permissions") {
    ZStack {
        AmbientBackgroundView()
        EmptyStateView.permissionsDisabled()
    }
    .preferredColorScheme(.dark)
}
