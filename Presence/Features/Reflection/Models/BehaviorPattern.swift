import Foundation

// MARK: - Behavior Pattern

/// Represents an observed pattern over time regarding the user's habits.
public struct BehaviorPattern: Identifiable, Equatable {
    public let id: UUID
    public let timestamp: Date
    public let title: String
    public let description: String
    public let impactScore: Int // -100 (Negative Impact) to 100 (Positive Impact)
    public let category: PatternCategory
    
    public enum PatternCategory: String, Codable {
        case sleep
        case focus
        case recovery
        case screenTime
        case general
    }
    
    public init(id: UUID = UUID(), timestamp: Date = Date(), title: String, description: String, impactScore: Int, category: PatternCategory) {
        self.id = id
        self.timestamp = timestamp
        self.title = title
        self.description = description
        self.impactScore = impactScore
        self.category = category
    }
}

// MARK: - Mock Data

public extension BehaviorPattern {
    /// Sample data for SwiftUI previews and initial state
    static let mockData: [BehaviorPattern] = [
        BehaviorPattern(
            timestamp: Date().addingTimeInterval(-86400 * 2),
            title: "Late Screen Time",
            description: "Using social media after 11 PM consistently reduces your deep sleep by 20%.",
            impactScore: -30,
            category: .sleep
        ),
        BehaviorPattern(
            timestamp: Date().addingTimeInterval(-86400 * 1),
            title: "Morning Flow State",
            description: "You achieve your highest focus scores between 9 AM and 11 AM.",
            impactScore: 85,
            category: .focus
        )
    ]
}
