import Foundation
import SwiftUI
import Combine

@Observable
public final class AnalyticsViewModel {
    public var dashboardData: BehavioralDashboardData?
    public var isLoading: Bool = false
    public var errorMessage: String? = nil
    
    // MARK: - Computed Properties for Easy Access
    public var sleepTrends: [SleepTrend] { dashboardData?.sleepTrends ?? [] }
    public var focusTrends: [FocusTrend] { dashboardData?.focusTrends ?? [] }
    public var recoveryTrends: [RecoveryTrend] { dashboardData?.recoveryTrends ?? [] }
    public var screenTimeTrends: [ScreenTimeTrend] { dashboardData?.screenTimeTrends ?? [] }
    
    public init() {}
    
    // MARK: - Async Data Fetching
    
    @MainActor
    public func loadAnalyticsData() async {
        isLoading = true
        errorMessage = nil
        
        let healthData = HealthDataService.shared
        
        do {
            // Parallel fetch of real behavioral data
            async let sleepSummary = healthData.getWeeklySleepSummary()
            async let heartMetrics = healthData.getLatestHeartMetrics()
            
            let (sleep, heart) = await (sleepSummary, heartMetrics)
            
            // Map real data to display models
            // In a production app, we would calculate daily data points here.
            // For now, we populate the dashboard data with aggregated real values.
            self.dashboardData = BehavioralDashboardData(
                sleepTrends: [SleepTrend(id: UUID(), date: Date(), hours: sleep.averageDuration / 3600)],
                focusTrends: [],
                recoveryTrends: [RecoveryTrend(id: UUID(), date: Date(), score: Int(heart.hrv ?? 50))],
                screenTimeTrends: []
            )
        } catch {
            self.errorMessage = "Failed to load analytics: \(error.localizedDescription)"
        }
        
        isLoading = false
    }
}
