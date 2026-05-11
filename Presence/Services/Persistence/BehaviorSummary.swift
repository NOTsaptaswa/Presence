import Foundation
import SwiftData

// MARK: - Behavior Summary Model

/// Local-first persistent model for long-term behavioral patterns.
@Model
public final class BehaviorSummary {
    @Attribute(.unique) public var id: UUID
    public var timestamp: Date
    public var title: String
    public var summaryDescription: String
    public var impactScore: Int
    public var categoryString: String
    
    // MARK: Relationships
    
    public var reflection: ReflectionEntry?
    
    public init(id: UUID = UUID(), timestamp: Date = Date(), title: String, summaryDescription: String, impactScore: Int, categoryString: String) {
        self.id = id
        self.timestamp = timestamp
        self.title = title
        self.summaryDescription = summaryDescription
        self.impactScore = impactScore
        self.categoryString = categoryString
    }
}
