//
//  BehavioralNudgeService.swift
//  Presence
//
//  Intelligence layer that generates nudge content based on behavioral patterns.
//

import Foundation

/// Service responsible for generating intelligent, empathetic behavioral nudges.
public final class BehavioralNudgeService {
    
    public static let shared = BehavioralNudgeService()
    
    private init() {}
    
    // MARK: - Nudge Content Generation
    
    /// Generates a nudge for irregular sleep patterns.
    public func sleepConsistencyNudge(deviationMinutes: Int) -> PresenceNotificationContent {
        let body = deviationMinutes > 60 
            ? "Your sleep timing shifted by \(deviationMinutes)m last night. Try to anchor your bedtime tonight for better recovery."
            : "Consistency is key. You're doing great—try to hit your target bedtime again tonight."
            
        return PresenceNotificationContent(
            title: "Sleep Consistency",
            body: body,
            category: .sleep
        )
    }
    
    /// Generates a nudge for low recovery scores.
    public func recoveryHabitNudge(score: Int) -> PresenceNotificationContent {
        let body = score < 50
            ? "Your recovery is lower than usual (\(score)%). Prioritize light activity and earlier rest today."
            : "Recovery is optimal. Today is a great day for deep focus or physical challenge."
            
        return PresenceNotificationContent(
            title: "Recovery Insight",
            body: body,
            category: .recovery
        )
    }
    
    /// Generates a nudge for high screen time.
    public func screenTimeBalanceNudge(hours: Double) -> PresenceNotificationContent {
        return PresenceNotificationContent(
            title: "Digital Balance",
            body: "You've reached \(String(format: "%.1f", hours))h of screen time today. Consider a 15-minute tech-free break to reset.",
            category: .screenTime
        )
    }
    
    /// Generates a gentle reminder for the nightly reflection.
    public func reflectionReminder() -> PresenceNotificationContent {
        return PresenceNotificationContent(
            title: "Daily Reflection",
            body: "Take a moment to check in with yourself. How did your focus feel today?",
            category: .reflection
        )
    }
    
    /// Generates a nudge for focus sessions.
    public func focusMomentumNudge() -> PresenceNotificationContent {
        return PresenceNotificationContent(
            title: "Focus Momentum",
            body: "You've had a productive morning. Protect your focus for one more deep work block.",
            category: .focus
        )
    }
}
