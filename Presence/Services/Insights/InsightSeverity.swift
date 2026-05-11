import Foundation
import SwiftUI

// MARK: - Insight Severity

/// Represents the importance, impact, and urgency of a behavioral insight.
public enum InsightSeverity: Int, Codable, Comparable {
    case low = 0
    case moderate = 1
    case high = 2
    case critical = 3
    
    public static func < (lhs: InsightSeverity, rhs: InsightSeverity) -> Bool {
        return lhs.rawValue < rhs.rawValue
    }
    
    /// User-facing string representation
    public var title: String {
        switch self {
        case .low: return "Minor"
        case .moderate: return "Notable"
        case .high: return "Important"
        case .critical: return "Critical"
        }
    }
    
    /// Recommended UI color mapping for this severity
    public var color: Color {
        switch self {
        case .low: return .secondary
        case .moderate: return .blue
        case .high: return .orange
        case .critical: return .red
        }
    }
}
