//
//  InsightsViewModel.swift
//  Presence
//
//  ViewModel for managing the presentation of AI behavioral insights.
//

import Foundation
import Observation

@Observable
public final class InsightsViewModel {
    
    private let engine = AIInsightEngine.shared
    
    public var insights: [BehavioralInsight] {
        engine.latestInsights
    }
    
    public var isAnalyzing: Bool {
        engine.isAnalyzing
    }
    
    public init() {}
    
    /// Requests a fresh analysis from the engine.
    @MainActor
    public func refreshInsights() async {
        await engine.generateDailyInsights()
    }
}
