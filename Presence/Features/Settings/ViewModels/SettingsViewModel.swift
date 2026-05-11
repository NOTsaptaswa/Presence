//
//  SettingsViewModel.swift
//  Presence
//
//  Manages user preferences and system settings.
//

import Foundation
import Observation
import SwiftUI

@Observable
public final class SettingsViewModel {
    
    // MARK: - Properties (Persisted via AppStorage/UserDefaults)
    
    public var isNotificationsEnabled: Bool {
        get { UserDefaults.standard.bool(forKey: "isNotificationsEnabled") }
        set { UserDefaults.standard.set(newValue, forKey: "isNotificationsEnabled") }
    }
    
    public var selectedTheme: String {
        get { UserDefaults.standard.string(forKey: "selectedTheme") ?? "System" }
        set { UserDefaults.standard.set(newValue, forKey: "selectedTheme") }
    }
    
    // MARK: - Computed Properties
    
    public var themeOptions: [String] = ["System", "Light", "Dark"]
    
    public init() {}
    
    // MARK: - Actions
    
    /// Resets the onboarding state to allow testing the flow again.
    public func resetOnboarding() {
        UserDefaults.standard.set(false, forKey: "hasCompletedOnboarding")
        HapticsManager.shared.warning()
        
        // In a real app, you might want to force a view refresh or app restart
    }
    
    /// Simulates a data export of behavioral patterns.
    public func exportData() {
        HapticsManager.shared.success()
        // Logic for generating and sharing a JSON/CSV file would go here.
    }
    
    /// Directs the user to the system health permissions.
    public func openHealthSettings() {
        if let url = URL(string: "x-apple-health://") {
            UIApplication.shared.open(url)
        }
    }
}
