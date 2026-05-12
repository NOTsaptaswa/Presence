//
//  BehavioralInsight.swift
//  Presence
//
//  Core model for AI-generated behavioral insights.
//

import Foundation
import SwiftUI

/// Represents a single behavioral insight or recommendation.
public struct BehavioralInsight: Identifiable, Codable {
    public let id: UUID
    public let title: String
    public let message: String
    public let category: InsightCategory
    public let priority: InsightPriority
    public let createdAt: Date
    
    public init(
        id: UUID = UUID(),
        title: String,
        message: String,
        category: InsightCategory,
        priority: InsightPriority,
        createdAt: Date = Date()
    ) {
        self.id = id
        self.title = title
        self.message = message
        self.category = category
        self.priority = priority
        self.createdAt = createdAt
    }
}

public enum InsightCategory: String, Codable, CaseIterable {
    case sleep, recovery, focus, screenTime, consistency, general
    
    public var icon: String {
        switch self {
        case .sleep: return "moon.zzz.fill"
        case .recovery: return "heart.text.square.fill"
        case .focus: return "brain.head.profile"
        case .screenTime: return "iphone"
        case .consistency: return "calendar.badge.clock"
        case .general: return "sparkles"
        }
    }
    
    public var color: Color {
        switch self {
        case .sleep: return .indigo
        case .recovery: return .red
        case .focus: return .purple
        case .screenTime: return .blue
        case .consistency: return .orange
        case .general: return .teal
        }
    }
}

public enum InsightPriority: String, Codable, CaseIterable {
    case positive      // "You're doing great"
    case recommendation // "Try this to improve"
    case warning       // "Significant decline detected"
    case informational // "Did you know?"
    
    public var icon: String {
        switch self {
        case .positive: return "checkmark.circle.fill"
        case .recommendation: return "lightbulb.fill"
        case .warning: return "exclamationmark.triangle.fill"
        case .informational: return "info.circle.fill"
        }
    }
}
