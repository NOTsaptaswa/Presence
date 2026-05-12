//
//  DeviceActivityManager.swift
//  Presence
//
//  Manages Screen Time and DeviceActivity framework integration.
//  Requires FamilyControls authorization for production usage.
//

import Foundation
import FamilyControls
import DeviceActivity
import Observation
import ManagedSettings

import os

@Observable
public final class DeviceActivityManager {
    public static let shared = DeviceActivityManager()
    
    private let center = DeviceActivityCenter()
    private let store = ManagedSettingsStore()
    private let logger = Logger(subsystem: "com.presence.app", category: "ScreenTime")
    
    public var isAuthorized = false
    public var authorizationError: String?
    
    private init() {
        Task {
            await checkAuthorization()
        }
    }
    
    // MARK: - Authorization
    
    @MainActor
    public func requestAuthorization() async {
        do {
            try await AuthorizationCenter.shared.requestAuthorization(for: .individual)
            isAuthorized = true
            logger.info("DeviceActivity authorization granted.")
        } catch {
            isAuthorized = false
            authorizationError = error.localizedDescription
            logger.error("DeviceActivity authorization failed: \(error.localizedDescription)")
        }
    }
    
    @MainActor
    private func checkAuthorization() async {
        isAuthorized = AuthorizationCenter.shared.authorizationStatus == .approved
    }
    
    // MARK: - Activity Monitoring
    
    /// Starts monitoring for behavioral screen time patterns.
    /// Uses DeviceActivitySchedules to detect high digital usage windows.
    public func startMonitoringBehavior() {
        guard isAuthorized else { return }
        
        let schedule = DeviceActivitySchedule(
            intervalStart: DateComponents(hour: 0, minute: 0),
            intervalEnd: DateComponents(hour: 23, minute: 59),
            repeats: true
        )
        
        let name = DeviceActivityName("presence.behavior.monitoring")
        
        do {
            try center.startMonitoring(name, during: schedule)
            logger.info("Monitoring started for \(name.rawValue)")
        } catch {
            logger.error("Failed to start monitoring: \(error.localizedDescription)")
        }
    }
    
    /// Calculates a 'Digital Balance' score based on recent screen time fragmentation.
    public func calculateDigitalBalance() -> Double {
        // In a production app, this would query the DeviceActivityReport.
        // Returning a base score if authorized, or 0.0 if not.
        return isAuthorized ? 0.75 : 0.0
    }
}

