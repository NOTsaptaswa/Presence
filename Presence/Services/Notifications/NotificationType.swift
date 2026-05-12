//
//  NotificationType.swift
//  Presence
//
//  Defines the granular categories for behavioral nudges.
//

import Foundation

/// Represents the different types of notifications Presence can send.
public enum NotificationCategory: String, CaseIterable, Codable {
    case reflection = "presence.category.reflection"
    case sleep = "presence.category.sleep"
    case recovery = "presence.category.recovery"
    case focus = "presence.category.focus"
    case screenTime = "presence.category.screentime"
    
    public var title: String {
        switch self {
        case .reflection: return "Daily Reflection"
        case .sleep: return "Sleep Consistency"
        case .recovery: return "Recovery Alerts"
        case .focus: return "Focus Session"
        case .screenTime: return "Screen Time"
        }
    }
    
    public var icon: String {
        switch self {
        case .reflection: return "pencil.and.outline"
        case .sleep: return "moon.zzz.fill"
        case .recovery: return "heart.text.square.fill"
        case .focus: return "brain.head.profile"
        case .screenTime: return "iphone"
        }
    }
}

/// A data model for generating localized notification content.
public struct PresenceNotificationContent {
    public let title: String
    public let body: String
    public let category: NotificationCategory
    
    public init(title: String, body: String, category: NotificationCategory) {
        self.title = title
        self.body = body
        self.category = category
    }
}
