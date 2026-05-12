//
//  SettingsService.swift
//  Presence
//
//  Handles the persistence of lightweight user preferences and configuration.
//

import Foundation
import SwiftUI
import Observation

@Observable
public final class SettingsService {
    
    public static let shared = SettingsService()
    
    // MARK: - Keys
    private enum Keys {
        static let appearance = "presence.settings.appearance"
        static let onboardingComplete = "hasCompletedOnboarding"
        static let notificationsEnabled = "presence.settings.notifications.enabled"
        static let reflectionHour = "presence.settings.reflection.hour"
    }
    
    // MARK: - Properties
    
    public var appearance: AppAppearance {
        get {
            access(keyPath: \.appearance)
            let rawValue = UserDefaults.standard.string(forKey: Keys.appearance) ?? AppAppearance.system.rawValue
            return AppAppearance(rawValue: rawValue) ?? .system
        }
        set {
            withMutation(keyPath: \.appearance) {
                UserDefaults.standard.set(newValue.rawValue, forKey: Keys.appearance)
            }
        }
    }
    
    public var isOnboardingComplete: Bool {
        get {
            access(keyPath: \.isOnboardingComplete)
            return UserDefaults.standard.bool(forKey: Keys.onboardingComplete)
        }
        set {
            withMutation(keyPath: \.isOnboardingComplete) {
                UserDefaults.standard.set(newValue, forKey: Keys.onboardingComplete)
            }
        }
    }
    
    public var isNotificationsEnabled: Bool {
        get {
            access(keyPath: \.isNotificationsEnabled)
            return UserDefaults.standard.bool(forKey: Keys.notificationsEnabled)
        }
        set {
            withMutation(keyPath: \.isNotificationsEnabled) {
                UserDefaults.standard.set(newValue, forKey: Keys.notificationsEnabled)
            }
        }
    }
    
    private init() {}
    
    // MARK: - Actions
    
    public func resetAllData() {
        // Clear User Defaults
        let domain = Bundle.main.bundleIdentifier!
        UserDefaults.standard.removePersistentDomain(forName: domain)
        UserDefaults.standard.synchronize()
        
        // Note: Real production app might also clear SwiftData/HealthKit local caches here.
    }
}
