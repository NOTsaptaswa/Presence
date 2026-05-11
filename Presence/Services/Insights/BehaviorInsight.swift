import Foundation

// MARK: - Behavior Insight

/// A singular intelligence observation derived from multiple data sources (e.g., Sleep + Focus).
public struct BehaviorInsight: Identifiable, Equatable {
    public let id: UUID
    public let timestamp: Date
    public let title: String
    public let description: String
    public let severity: InsightSeverity
    public let category: InsightCategory
    public let suggestedAction: String?
    
    public enum InsightCategory: String, Codable {
        case recovery
        case focus
        case sleep
        case screenTime
        case correlation
    }
    
    public init(id: UUID = UUID(), timestamp: Date = Date(), title: String, description: String, severity: InsightSeverity, category: InsightCategory, suggestedAction: String? = nil) {
        self.id = id
        self.timestamp = timestamp
        self.title = title
        self.description = description
        self.severity = severity
        self.category = category
        self.suggestedAction = suggestedAction
    }
}

// MARK: - Mock Data

public extension BehaviorInsight {
    /// Sample data for UI prototyping and Swift Previews
    static let mockData: [BehaviorInsight] = [
        BehaviorInsight(
            title: "Sleep-Focus Correlation",
            description: "Your flow state duration drops by 40% when you get less than 6 hours of sleep.",
            severity: .high,
            category: .correlation,
            suggestedAction: "Aim for at least 7 hours of sleep tonight to restore peak cognitive performance."
        ),
        BehaviorInsight(
            title: "High Screen Time Impact",
            description: "Social media usage late at night is delaying your deep sleep onset.",
            severity: .moderate,
            category: .screenTime,
            suggestedAction: "Enable iOS Sleep Focus 1 hour before bedtime."
        ),
        BehaviorInsight(
            title: "Recovery Peak Detected",
            description: "Your Heart Rate Variability (HRV) is highly elevated today, indicating excellent physical readiness.",
            severity: .low, // Low severity (urgency), but highly positive
            category: .recovery
        )
    ]
}
