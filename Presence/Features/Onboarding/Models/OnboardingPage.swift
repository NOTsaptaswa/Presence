import Foundation
import SwiftUI

// MARK: - Onboarding Page Model

/// Represents a single, modular slide within the app's onboarding flow.
public struct OnboardingPage: Identifiable, Equatable {
    public let id: UUID
    public let title: String
    public let subtitle: String
    public let systemImage: String
    public let accentColor: Color?
    
    public init(
        id: UUID = UUID(),
        title: String,
        subtitle: String,
        systemImage: String,
        accentColor: Color? = nil
    ) {
        self.id = id
        self.title = title
        self.subtitle = subtitle
        self.systemImage = systemImage
        self.accentColor = accentColor
    }
}

// MARK: - Default Data

public extension OnboardingPage {
    /// The standard predefined onboarding flow for Presence.
    static let standardFlow: [OnboardingPage] = [
        OnboardingPage(
            title: "Welcome to Presence",
            subtitle: "Your personal, privacy-first behavioral analytics engine designed for clarity and calm.",
            systemImage: "moon.stars.fill",
            accentColor: .indigo
        ),
        OnboardingPage(
            title: "Calm Analytics",
            subtitle: "We analyze your sleep, focus, and recovery trends without overwhelming you with noisy data.",
            systemImage: "chart.xyaxis.line",
            accentColor: .teal
        ),
        OnboardingPage(
            title: "Intelligent Insights",
            subtitle: "Receive perfectly timed, actionable insights to optimize your daily routine and well-being.",
            systemImage: "sparkles",
            accentColor: .purple
        ),
        OnboardingPage(
            title: "Your Data, Your Device",
            subtitle: "Presence is local-first. We sync securely with Apple Health and your data never leaves your device.",
            systemImage: "lock.shield.fill",
            accentColor: .green
        )
    ]
}
