import Foundation

// MARK: - Daily Reflection

/// The main aggregate object for a user's daily reflection and insights.
public struct DailyReflection: Identifiable, Equatable {
    public let id: UUID
    public let date: Date
    public let userNotes: String?
    public let overallMood: MoodRating
    public let insights: [ReflectionInsight]
    public let patterns: [BehaviorPattern]
    
    public enum MoodRating: Int, Codable {
        case terrible = 1
        case poor = 2
        case neutral = 3
        case good = 4
        case excellent = 5
    }
    
    public init(id: UUID = UUID(), date: Date = Date(), userNotes: String? = nil, overallMood: MoodRating, insights: [ReflectionInsight] = [], patterns: [BehaviorPattern] = []) {
        self.id = id
        self.date = date
        self.userNotes = userNotes
        self.overallMood = overallMood
        self.insights = insights
        self.patterns = patterns
    }
}

// MARK: - Mock Data

public extension DailyReflection {
    /// Sample data for SwiftUI previews and initial state
    static let mock: DailyReflection = DailyReflection(
        date: Date(),
        userNotes: "Felt very energized today after a full night of uninterrupted rest. Managed to stay in flow state for over 3 hours.",
        overallMood: .excellent,
        insights: ReflectionInsight.mockData,
        patterns: BehaviorPattern.mockData
    )
}
