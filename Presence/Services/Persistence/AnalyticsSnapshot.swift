import Foundation
import SwiftData

// MARK: - Analytics Snapshot Model

/// Local-first persistent model storing an aggregate of the daily analytics for fast rendering.
@Model
public final class AnalyticsSnapshot {
    @Attribute(.unique) public var id: UUID
    public var date: Date
    
    // MARK: Aggregated Metrics
    
    // Sleep
    public var sleepDurationHours: Double
    public var sleepQualityScore: Int
    
    // Focus
    public var focusDurationHours: Double
    public var focusFlowScore: Int
    
    // Recovery
    public var recoveryScore: Int
    public var restingHeartRate: Int
    public var heartRateVariability: Double
    
    // Screen Time
    public var screenTimeTotalHours: Double
    public var screenTimeProductivityHours: Double
    
    public init(
        id: UUID = UUID(),
        date: Date = Date(),
        sleepDurationHours: Double,
        sleepQualityScore: Int,
        focusDurationHours: Double,
        focusFlowScore: Int,
        recoveryScore: Int,
        restingHeartRate: Int,
        heartRateVariability: Double,
        screenTimeTotalHours: Double,
        screenTimeProductivityHours: Double
    ) {
        self.id = id
        self.date = date
        self.sleepDurationHours = sleepDurationHours
        self.sleepQualityScore = sleepQualityScore
        self.focusDurationHours = focusDurationHours
        self.focusFlowScore = focusFlowScore
        self.recoveryScore = recoveryScore
        self.restingHeartRate = restingHeartRate
        self.heartRateVariability = heartRateVariability
        self.screenTimeTotalHours = screenTimeTotalHours
        self.screenTimeProductivityHours = screenTimeProductivityHours
    }
}
