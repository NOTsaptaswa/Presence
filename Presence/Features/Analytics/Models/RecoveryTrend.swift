import Foundation

/// Represents physical and mental recovery metrics
public struct RecoveryTrend: TrendDataPoint, Equatable {
    public let id: UUID
    public let date: Date
    public let score: Int // 0-100
    public let restingHeartRate: Int // bpm
    public let heartRateVariability: Double // ms
    
    public init(id: UUID = UUID(), date: Date, score: Int, restingHeartRate: Int, heartRateVariability: Double) {
        self.id = id
        self.date = date
        self.score = score
        self.restingHeartRate = restingHeartRate
        self.heartRateVariability = heartRateVariability
    }
}
