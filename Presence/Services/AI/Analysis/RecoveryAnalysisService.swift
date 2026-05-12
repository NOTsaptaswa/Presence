//
//  RecoveryAnalysisService.swift
//  Presence
//
//  Analyzes recovery trends and identifies stability patterns.
//

import Foundation

public final class RecoveryAnalysisService {
    
    public init() {}
    
    /// Analyzes the long-term trend of recovery scores.
    public func analyzeTrend(history: [RecoveryMetric]) -> RecoveryTrendResult {
        // Mock logic: detect if scores are generally increasing, decreasing, or stable.
        return .improving(percentage: 8.0)
    }
}

public enum RecoveryTrendResult {
    case improving(percentage: Double)
    case declining(percentage: Double)
    case stable
}
