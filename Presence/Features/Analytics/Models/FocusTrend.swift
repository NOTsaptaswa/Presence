import Foundation

/// Represents a single day's focus and productivity metrics
public struct FocusTrend: TrendDataPoint, Equatable {
    public let id: UUID
    public let date: Date
    public let durationHours: Double
    public let interruptionsCount: Int
    public let flowStateScore: Int // 0-100
    
    public init(id: UUID = UUID(), date: Date, durationHours: Double, interruptionsCount: Int, flowStateScore: Int) {
        self.id = id
        self.date = date
        self.durationHours = durationHours
        self.interruptionsCount = interruptionsCount
        self.flowStateScore = flowStateScore
    }
}
