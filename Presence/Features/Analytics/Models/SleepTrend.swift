import Foundation

/// Represents a single day's sleep data
public struct SleepTrend: TrendDataPoint, Equatable {
    public let id: UUID
    public let date: Date
    public let durationHours: Double
    public let qualityScore: Int // 0-100
    public let deepSleepHours: Double
    
    public init(id: UUID = UUID(), date: Date, durationHours: Double, qualityScore: Int, deepSleepHours: Double) {
        self.id = id
        self.date = date
        self.durationHours = durationHours
        self.qualityScore = qualityScore
        self.deepSleepHours = deepSleepHours
    }
}
