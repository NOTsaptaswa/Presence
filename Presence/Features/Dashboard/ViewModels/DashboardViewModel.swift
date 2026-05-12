//
//  DashboardViewModel.swift
//  Presence
//
//  Created by Saptaswa Nandi on 09/05/26.
//


import Foundation
import Observation

@Observable
final class DashboardViewModel {
    
    var isLoading: Bool = true
    var metrics: [DashboardMetric] = []
    private let healthDataService = HealthDataService.shared
    private let scoringEngine = ScoringEngine.shared
    
    @MainActor
    func loadDashboard() async {
        isLoading = true
        
        // Parallel data fetching
        async let sleepData = healthDataService.getWeeklySleepSummary()
        async let heartData = healthDataService.getLatestHeartMetrics()
        async let steps = healthDataService.getTodaySteps()
        
        let (sleep, heart, todaySteps) = await (sleepData, heartData, steps)
        
        // Calculate Behavioral Scores
        let scores = scoringEngine.calculateScores(
            sleepConsistency: sleep.consistencyScore,
            hrvStability: (heart.hrv ?? 50.0) / 100.0, // Simplified normalization
            activityLevel: Double(todaySteps) / 10000.0, // Normalized to 10k steps
            screenTimeBalance: 0.75 // Placeholder for ScreenTime integration
        )
        
        // Update Metrics
        self.metrics = [
            DashboardMetric(
                title: "Recovery",
                value: "\(scores.recovery)%",
                systemImage: "heart.fill"
            ),
            DashboardMetric(
                title: "Focus",
                value: "\(scores.focus)%",
                systemImage: "brain.head.profile"
            ),
            DashboardMetric(
                title: "Sleep",
                value: String(format: "%.1fh", sleep.averageDuration / 3600),
                systemImage: "bed.double.fill"
            ),
            DashboardMetric(
                title: "Daily Steps",
                value: "\(todaySteps)",
                systemImage: "figure.walk"
            )
        ]
        
        isLoading = false
    }
}