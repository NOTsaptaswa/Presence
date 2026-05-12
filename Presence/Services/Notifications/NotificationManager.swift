//
//  NotificationManager.swift
//  Presence
//
//  The central engine for the Presence notification system.
//  Wraps UserNotifications framework with async/await and @Observable.
//

import Foundation
import UserNotifications
import Observation

@Observable
public final class NotificationManager {
    
    public static let shared = NotificationManager()
    
    /// Tracks the current authorization status from the system.
    public var authorizationStatus: UNAuthorizationStatus = .notDetermined
    
    private let center = UNUserNotificationCenter.current()
    
    private init() {
        Task {
            await updateAuthorizationStatus()
        }
    }
    
    // MARK: - Permissions
    
    /// Requests notification permissions with a standard set of options.
    /// Should be called during the specialized onboarding flow.
    @discardableResult
    public func requestAuthorization() async -> Bool {
        do {
            let granted = try await center.requestAuthorization(options: [.alert, .sound, .badge])
            await updateAuthorizationStatus()
            
            if granted {
                registerCategories()
            }
            
            return granted
        } catch {
            print("❌ NotificationManager: Error requesting authorization: \(error)")
            return false
        }
    }
    
    /// Refreshes the internal status from the system.
    public func updateAuthorizationStatus() async {
        let settings = await center.notificationSettings()
        self.authorizationStatus = settings.authorizationStatus
    }
    
    // MARK: - Scheduling
    
    /// Schedules a local notification with a specific trigger.
    public func scheduleNotification(
        id: String,
        content: PresenceNotificationContent,
        trigger: UNNotificationTrigger
    ) async {
        let unContent = UNMutableNotificationContent()
        unContent.title = content.title
        unContent.body = content.body
        unContent.categoryIdentifier = content.category.rawValue
        unContent.sound = .default
        
        let request = UNNotificationRequest(
            identifier: id,
            content: unContent,
            trigger: trigger
        )
        
        do {
            try await center.add(request)
        } catch {
            print("❌ NotificationManager: Failed to schedule notification \(id): \(error)")
        }
    }
    
    /// Cancels a specific pending notification.
    public func cancelNotification(id: String) {
        center.removePendingNotificationRequests(withIdentifiers: [id])
    }
    
    /// Clears all notifications for a specific category.
    public func cancelAllNotifications(for category: NotificationCategory) {
        // Unfortunately UNUserNotificationCenter doesn't support filtering by category for removal easily.
        // We handle this by using predictable prefix-based identifiers.
        Task {
            let pending = await center.pendingNotificationRequests()
            let idsToRemove = pending
                .filter { $0.content.categoryIdentifier == category.rawValue }
                .map { $0.identifier }
            
            center.removePendingNotificationRequests(withIdentifiers: idsToRemove)
        }
    }
    
    // MARK: - Category Setup
    
    /// Registers the categories so the system knows how to handle actions or specialized display.
    private func registerCategories() {
        let categories: Set<UNNotificationCategory> = Set(
            NotificationCategory.allCases.map { category in
                UNNotificationCategory(
                    identifier: category.rawValue,
                    actions: [],
                    intentIdentifiers: [],
                    options: .customDismissAction
                )
            }
        )
        
        center.setNotificationCategories(categories)
    }
}
