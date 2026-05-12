//
//  RecommendationGenerator.swift
//  Presence
//
//  Generates natural language, empathetic behavioral recommendations.
//

import Foundation

public final class RecommendationGenerator {
    
    public init() {}
    
    /// Generates a localized, calm recommendation string based on analysis results.
    public func generate(for category: InsightCategory, priority: InsightPriority) -> String {
        switch (category, priority) {
        case (.sleep, .positive):
            return "Your recovery improved significantly after consistent sleep timing this week. Great work protecting your rest."
        case (.screenTime, .recommendation):
            return "Focus tends to decline after high evening digital usage. A 20-minute tech-free reset tonight could improve tomorrow's clarity."
        case (.recovery, .warning):
            return "Recovery stability is showing a downward trend. Prioritizing low-intensity movement and earlier rest today might help reset your baseline."
        case (.focus, .informational):
            return "You consistently reach peak focus between 10 AM and 1 PM. Protecting this window for deep work could boost your output."
        default:
            return "Consistency in your daily routines is the strongest predictor of long-term mental and physical clarity."
        }
    }
}
