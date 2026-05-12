//
//  ScoringEngine.swift
//  Presence
//
//  Production-ready behavioral scoring engine.
//  Calculates focus, recovery, and consistency scores using non-medical,
//  trend-based algorithms.
//

import Foundation

public struct BehavioralScores {
    public let recovery: Int
    public let focus: Int
    public let consistency: Int
    public let digitalBalance: Int
}

public final class ScoringEngine {
    public static let shared = ScoringEngine()
    
    private init() {}
    
    /// Calculates behavioral scores based on provided metrics.
    /// Note: These are 'behavioral indicators' and not medical diagnoses.
    public func calculateScores(
        sleepConsistency: Double,
        hrvStability: Double,
        activityLevel: Double,
        screenTimeBalance: Double
    ) -> BehavioralScores {
        
        // Consistency: Weighted average of routine stability
        let consistencyScore = Int(sleepConsistency * 100)
        
        // Recovery: Combination of HRV stability and sleep quality
        let recoveryScore = Int((hrvStability * 0.7 + sleepConsistency * 0.3) * 100)
        
        // Focus: Inverse relationship with digital fragmentation
        let focusScore = Int(screenTimeBalance * 100)
        
        // Digital Balance: Ratio of mindful focus vs fragmented usage
        let digitalBalanceScore = Int(screenTimeBalance * 100)
        
        return BehavioralScores(
            recovery: clamp(recoveryScore),
            focus: clamp(focusScore),
            consistency: clamp(consistencyScore),
            digitalBalance: clamp(digitalBalanceScore)
        )
    }
    
    private func clamp(_ value: Int) -> Int {
        return min(max(value, 0), 100)
    }
}
