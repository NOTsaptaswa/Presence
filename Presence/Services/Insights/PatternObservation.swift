import Foundation

// MARK: - Pattern Observation

/// Represents a recurring sequence of behaviors identified by the intelligence engine over time.
public struct PatternObservation: Identifiable, Equatable {
    public let id: UUID
    public let firstObserved: Date
    public let lastObserved: Date
    public let occurrenceCount: Int
    public let patternName: String
    public let analysis: String
    
    public init(id: UUID = UUID(), firstObserved: Date, lastObserved: Date, occurrenceCount: Int, patternName: String, analysis: String) {
        self.id = id
        self.firstObserved = firstObserved
        self.lastObserved = lastObserved
        self.occurrenceCount = occurrenceCount
        self.patternName = patternName
        self.analysis = analysis
    }
}

// MARK: - Mock Data

public extension PatternObservation {
    /// Sample data for UI prototyping and Swift Previews
    static let mockData: [PatternObservation] = [
        PatternObservation(
            firstObserved: Calendar.current.date(byAdding: .day, value: -30, to: Date()) ?? Date(),
            lastObserved: Date(),
            occurrenceCount: 12,
            patternName: "Weekend Sleep Debt",
            analysis: "You consistently sleep 2 hours less on weekends, which directly correlates to lower Monday recovery scores and reduced morning focus."
        )
    ]
}
