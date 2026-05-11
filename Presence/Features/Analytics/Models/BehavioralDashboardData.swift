import Foundation

/// Main container model for the behavioral dashboard
public struct BehavioralDashboardData: Equatable {
    public let sleepTrends: [SleepTrend]
    public let focusTrends: [FocusTrend]
    public let recoveryTrends: [RecoveryTrend]
    public let screenTimeTrends: [ScreenTimeTrend]
    
    // MARK: Computed Metrics
    
    public var latestRecoveryScore: Int {
        recoveryTrends.last?.score ?? 0
    }
    
    public var averageSleepDuration: Double {
        guard !sleepTrends.isEmpty else { return 0 }
        let total = sleepTrends.reduce(0) { $0 + $1.durationHours }
        return total / Double(sleepTrends.count)
    }
    
    public var averageFocusScore: Int {
        guard !focusTrends.isEmpty else { return 0 }
        let total = focusTrends.reduce(0) { $0 + $1.flowStateScore }
        return total / focusTrends.count
    }
    
    public init(
        sleepTrends: [SleepTrend] = [],
        focusTrends: [FocusTrend] = [],
        recoveryTrends: [RecoveryTrend] = [],
        screenTimeTrends: [ScreenTimeTrend] = []
    ) {
        self.sleepTrends = sleepTrends
        self.focusTrends = focusTrends
        self.recoveryTrends = recoveryTrends
        self.screenTimeTrends = screenTimeTrends
    }
}

// MARK: - Mock Data Generator

public extension BehavioralDashboardData {
    /// Provides sample mock data for UI previews and testing
    static var mock: BehavioralDashboardData {
        let calendar = Calendar.current
        let today = Date()
        
        // Generate past 7 days of mock data
        let dates: [Date] = (0..<7).reversed().compactMap { daysAgo in
            calendar.date(byAdding: .day, value: -daysAgo, to: today)
        }
        
        let sleep = dates.enumerated().map { index, date in
            SleepTrend(
                date: date,
                durationHours: Double.random(in: 6.0...8.5),
                qualityScore: Int.random(in: 70...95),
                deepSleepHours: Double.random(in: 1.5...2.5)
            )
        }
        
        let focus = dates.enumerated().map { index, date in
            FocusTrend(
                date: date,
                durationHours: Double.random(in: 2.0...6.0),
                interruptionsCount: Int.random(in: 2...10),
                flowStateScore: Int.random(in: 50...90)
            )
        }
        
        let recovery = dates.enumerated().map { index, date in
            RecoveryTrend(
                date: date,
                score: Int.random(in: 60...98),
                restingHeartRate: Int.random(in: 50...65),
                heartRateVariability: Double.random(in: 40...80)
            )
        }
        
        let screenTime = dates.enumerated().map { index, date in
            let total = Double.random(in: 3.0...7.0)
            let social = Double.random(in: 0.5...total * 0.4)
            let productivity = Double.random(in: 1.0...total * 0.5)
            return ScreenTimeTrend(
                date: date,
                totalHours: total,
                socialMediaHours: social,
                productivityHours: productivity
            )
        }
        
        return BehavioralDashboardData(
            sleepTrends: sleep,
            focusTrends: focus,
            recoveryTrends: recovery,
            screenTimeTrends: screenTime
        )
    }
}
