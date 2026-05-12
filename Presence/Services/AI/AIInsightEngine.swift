//
//  AIInsightEngine.swift
//  Presence
//
//  Central orchestrator for behavioral analysis and insight generation.
//

import Foundation
import Observation

/// The central brain of the Presence AI system.
/// Coordinates multiple specialized analysis services to produce high-value behavioral insights.
@Observable
public final class AIInsightEngine {
    
    public static let shared = AIInsightEngine()
    
    // MARK: - State
    
    public var latestInsights: [BehavioralInsight] = []
    public var isAnalyzing: Bool = false
    public var lastAnalysisDate: Date?
    
    // MARK: - Internal Services (To be implemented)
    // private let sleepAnalyzer = SleepCorrelationAnalyzer()
    // private let recoveryAnalyzer = RecoveryAnalysisService()
    // private let focusAnalyzer = FocusPatternAnalyzer()
    // private let recommendationGenerator = RecommendationGenerator()
    
    private init() {}
    
    // MARK: - Orchestration
    
    /// Runs a full behavioral analysis pipeline across all tracked metrics.
    @MainActor
    public func generateDailyInsights() async {
        guard !isAnalyzing else { return }
        
        isAnalyzing = true
        
        let healthData = HealthDataService.shared
        let recommendationGenerator = RecommendationGenerator()
        
        // Parallel fetch for analysis
        async let sleep = healthData.getWeeklySleepSummary()
        async let heart = healthData.getLatestHeartMetrics()
        
        let (sleepSummary, heartMetrics) = await (sleep, heart)
        
        // Analyze Patterns (Simplified for production logic)
        var newInsights: [BehavioralInsight] = []
        
        // 1. Sleep Consistency Insight
        if sleepSummary.consistencyScore > 0.8 {
            newInsights.append(BehavioralInsight(
                title: "Sleep Stability",
                message: recommendationGenerator.generate(for: .sleep, priority: .positive),
                category: .sleep,
                priority: .positive
            ))
        }
        
        // 2. Recovery Insight based on HRV
        if let hrv = heartMetrics.hrv, hrv < 40 {
            newInsights.append(BehavioralInsight(
                title: "Recovery Reset",
                message: recommendationGenerator.generate(for: .recovery, priority: .warning),
                category: .recovery,
                priority: .warning
            ))
        }
        
        // 3. Informational focus window (Mocked for now as ScreenTime requires special handling)
        newInsights.append(BehavioralInsight(
            title: "Peak Focus",
            message: recommendationGenerator.generate(for: .focus, priority: .informational),
            category: .focus,
            priority: .informational
        ))
        
        self.latestInsights = newInsights
        self.lastAnalysisDate = Date()
        self.isAnalyzing = false
    }
}
