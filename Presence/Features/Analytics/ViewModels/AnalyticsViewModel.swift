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
        
        do {
            // Simulate network/database delay for fluid UI testing
            try await Task.sleep(nanoseconds: 800_000_000)
            
            // In a real app, you would inject a Service layer and fetch data here.
            // Using the modular mock data generator for now.
            self.dashboardData = BehavioralDashboardData.mock
        } catch {
            self.errorMessage = "Failed to load analytics data: \(error.localizedDescription)"
        }
        
        isLoading = false
    }
}
