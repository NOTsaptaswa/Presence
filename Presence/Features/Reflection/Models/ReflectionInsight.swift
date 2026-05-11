import Foundation

// MARK: - Reflection Insight

/// A generated or manually created insight regarding a specific behavior.
public struct ReflectionInsight: Identifiable, Equatable {
    public let id: UUID
    public let timestamp: Date
    public let summary: String
    public let detailedObservation: String
    public let isSystemGenerated: Bool
    public let relatedPatternId: UUID?
    
    public init(id: UUID = UUID(), timestamp: Date = Date(), summary: String, detailedObservation: String, isSystemGenerated: Bool = true, relatedPatternId: UUID? = nil) {
        self.id = id
        self.timestamp = timestamp
        self.summary = summary
        self.detailedObservation = detailedObservation
        self.isSystemGenerated = isSystemGenerated
        self.relatedPatternId = relatedPatternId
    }
}

// MARK: - Mock Data

public extension ReflectionInsight {
    /// Sample data for SwiftUI previews and initial state
    static let mockData: [ReflectionInsight] = [
        ReflectionInsight(
            timestamp: Date().addingTimeInterval(-3600 * 4),
            summary: "Optimal Recovery",
            detailedObservation: "Your resting heart rate dropped below 55 bpm after going to bed before 10 PM.",
            isSystemGenerated: true
        ),
        ReflectionInsight(
            timestamp: Date().addingTimeInterval(-3600 * 2),
            summary: "Digital Distraction",
            detailedObservation: "Focus sessions were interrupted 4 times due to social media notifications.",
            isSystemGenerated: true
        )
    ]
}
