import Foundation
import SwiftData

// MARK: - Recovery Insight Model

/// Local-first persistent model for granular system-generated observations.
@Model
public final class RecoveryInsight {
    @Attribute(.unique) public var id: UUID
    public var timestamp: Date
    public var summary: String
    public var detailedObservation: String
    public var isSystemGenerated: Bool
    
    // MARK: Relationships
    
    public var reflection: ReflectionEntry?
    
    public init(id: UUID = UUID(), timestamp: Date = Date(), summary: String, detailedObservation: String, isSystemGenerated: Bool = true) {
        self.id = id
        self.timestamp = timestamp
        self.summary = summary
        self.detailedObservation = detailedObservation
        self.isSystemGenerated = isSystemGenerated
    }
}
