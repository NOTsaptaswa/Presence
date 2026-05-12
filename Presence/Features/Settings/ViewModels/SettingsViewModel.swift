//
//  SettingsViewModel.swift
//  Presence
//
//  Production-ready ViewModel for the Settings screen.
//  Coordinates permission states and user preferences.
//

import Foundation
import Observation
import SwiftUI

@Observable
public final class SettingsViewModel {
    
    // MARK: - Dependencies
    private let settingsService = SettingsService.shared
    private let healthManager = HealthKitManager.shared
    private let notificationManager = NotificationManager.shared
    private let deviceManager = DeviceActivityManager.shared
    
    // MARK: - Properties
    
    public var appearance: AppAppearance {
        get { settingsService.appearance }
        set { 
            settingsService.appearance = newValue
            HapticsManager.shared.selection()
        }
    }
    
    public var isNotificationsEnabled: Bool {
        get { settingsService.isNotificationsEnabled }
        set { 
            settingsService.isNotificationsEnabled = newValue 
            if newValue {
                Task { await requestNotificationAccess() }
            }
        }
    }
    
    public var healthStatus: String {
        healthManager.isAuthorized ? "Authorized" : "Not Authorized"
    }
    
    public var screenTimeStatus: String {
        deviceManager.isAuthorized ? "Authorized" : "Not Authorized"
    }
    
    public var appVersion: String {
        let version = Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String ?? "1.0.0"
        let build = Bundle.main.infoDictionary?["CFBundleVersion"] as? String ?? "1"
        return "Version \(version) (\(build))"
    }
    
    // MARK: - Initialization
    
    public init() {}
    
    // MARK: - Actions
    
    @MainActor
    public func requestHealthAccess() async {
        await healthManager.requestAuthorization()
        HapticsManager.shared.success()
    }
    
    @MainActor
    public func requestScreenTimeAccess() async {
        await deviceManager.requestAuthorization()
        HapticsManager.shared.success()
    }
    
    @MainActor
    public func requestNotificationAccess() async {
        await notificationManager.requestAuthorization()
    }
    
    public func resetOnboarding() {
        settingsService.isOnboardingComplete = false
        settingsService.resetAllData()
        HapticsManager.shared.warning()
    }
    
    public func openSystemSettings() {
        if let url = URL(string: UIApplication.openSettingsURLString) {
            UIApplication.shared.open(url)
        }
    }
    
    public func exportData() {
        // Mock export
        HapticsManager.shared.success()
    }
}
