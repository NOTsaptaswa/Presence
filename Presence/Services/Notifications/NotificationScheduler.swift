//
//  NotificationScheduler.swift
//  Presence
//
//  Orchestrates the scheduling of various behavioral nudges and reminders.
//

import Foundation
import UserNotifications

/// Orchestrator for scheduling specific behavioral reminders and nudges.
public final class NotificationScheduler {
    
    public static let shared = NotificationScheduler()
    
    private let manager = NotificationManager.shared
    private let nudges = BehavioralNudgeService.shared
    
    private init() {}
    
    // MARK: - Core Scheduling
    
    /// Schedules the daily reflection reminder.
    /// - Parameter hour: The hour (0-23) to trigger the reminder.
    public func scheduleReflectionReminder(at hour: Int, minute: Int = 0) async {
        // Cancel existing first
        manager.cancelAllNotifications(for: .reflection)
        
        let content = nudges.reflectionReminder()
        
        var components = DateComponents()
        components.hour = hour
        components.minute = minute
        
        let trigger = UNCalendarNotificationTrigger(dateMatching: components, repeats: true)
        
        await manager.scheduleNotification(
            id: "presence.reflection.daily",
            content: content,
            trigger: trigger
        )
    }
    
    /// Schedules a smart sleep consistency nudge based on historical data.
    /// In a production app, this would be called after a HealthKit sync.
    public func scheduleSleepNudge(deviation: Int) async {
        manager.cancelAllNotifications(for: .sleep)
        
        let content = nudges.sleepConsistencyNudge(deviationMinutes: deviation)
        
        // Trigger in 1 hour if it's evening, or tomorrow morning
        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 3600, repeats: false)
        
        await manager.scheduleNotification(
            id: "presence.sleep.consistency",
            content: content,
            trigger: trigger
        )
    }
    
    /// Schedules a focus nudge for the next peak productivity window.
    public func scheduleFocusNudge() async {
        manager.cancelAllNotifications(for: .focus)
        
        let content = nudges.focusMomentumNudge()
        
        // Example: Schedule for tomorrow at 10 AM
        var components = DateComponents()
        components.hour = 10
        components.minute = 0
        
        let trigger = UNCalendarNotificationTrigger(dateMatching: components, repeats: false)
        
        await manager.scheduleNotification(
            id: "presence.focus.momentum",
            content: content,
            trigger: trigger
        )
    }
    
    // MARK: - Bulk Management
    
    /// Cancels all scheduled behavioral notifications.
    public func cancelAllSchedules() {
        NotificationCategory.allCases.forEach { category in
            manager.cancelAllNotifications(for: category)
        }
    }
}
