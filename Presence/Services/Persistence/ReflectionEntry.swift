import Foundation
import SwiftData

// MARK: - Reflection Entry Model

/// Local-first persistent model for daily user reflections.
@Model
public final class ReflectionEntry {
    @Attribute(.unique) public var id: UUID
    public var date: Date
    public var userNotes: String?
    public var moodRatingValue: Int
    
    // MARK: Relationships
    
    @Relationship(deleteRule: .cascade, inverse: \BehaviorSummary.reflection)
    public var behaviorSummaries: [BehaviorSummary]?
    
    @Relationship(deleteRule: .cascade, inverse: \RecoveryInsight.reflection)
    public var recoveryInsights: [RecoveryInsight]?
    
    public init(id: UUID = UUID(), date: Date = Date(), userNotes: String? = nil, moodRatingValue: Int) {
        self.id = id
        self.date = date
        self.userNotes = userNotes
        self.moodRatingValue = moodRatingValue
    }
}
