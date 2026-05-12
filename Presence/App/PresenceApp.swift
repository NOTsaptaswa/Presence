//
//  PresenceApp.swift
//  Presence
//
//  Created by Saptaswa Nandi on 09/05/26.
//

import SwiftUI
import SwiftData

@main
struct PresenceApp: App {
    // Tracks if the user has finished the onboarding flow
    @State private var settings = SettingsService.shared
    @State private var showSplash: Bool = true
    
    var body: some Scene {
        WindowGroup {
            ZStack {
                if settings.isOnboardingComplete {
                    MainTabView()
                } else {
                    OnboardingView()
                }
                
                if showSplash {
                    LaunchScreenView()
                        .transition(.opacity)
                        .zIndex(1)
                }
            }
            .preferredColorScheme(settings.appearance.colorScheme)
            .task {
                // Keep splash visible for 2 seconds for a calm entry
                try? await Task.sleep(nanoseconds: 2_000_000_000)
                withAnimation(.easeOut(duration: 0.8)) {
                    showSplash = false
                }
            }
        }
        .modelContainer(
            for: [
                ReflectionEntry.self,
                BehaviorSummary.self,
                RecoveryInsight.self,
                AnalyticsSnapshot.self
            ]
        )
    }
}
