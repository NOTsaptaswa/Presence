import Foundation
import SwiftUI
import Combine

/// Manages the state and business logic for the Reflection feature.
@Observable
public final class ReflectionViewModel {
    
    // MARK: - Published State
    
    /// The current daily reflection being viewed or edited
    public var currentReflection: DailyReflection?
    
    /// Historical reflections for long-term trend analysis
    public var pastReflections: [DailyReflection] = []
    
    /// Loading state for async operations
    public var isLoading: Bool = false
    
    /// Any errors encountered during fetching or processing
    public var errorMessage: String? = nil
    
    // MARK: - Computed Properties
    
    /// Extracts all current actionable insights
    public var activeInsights: [ReflectionInsight] {
        currentReflection?.insights ?? []
    }
    
    /// Extracts all identified long-term behavioral patterns
    public var activePatterns: [BehaviorPattern] {
        currentReflection?.patterns ?? []
    }
    
    public init() {}
    
    // MARK: - Data Fetching & Integration
    
    /// Loads reflection data. Optimized for future HealthKit and core data integration.
    @MainActor
    public func loadReflections() async {
        isLoading = true
        errorMessage = nil
        
        do {
            // Simulate processing time for fetching data and running analytics algorithms
            try await Task.sleep(nanoseconds: 800_000_000)
            
            // TODO: Future HealthKit Integration
            // 1. Fetch raw sleep and recovery data via HealthKitManager
            // 2. Pass data into an InsightGeneratorService
            // 3. Construct real DailyReflection objects based on generated insights
            
            // For now, load our mock data
            self.currentReflection = DailyReflection.mock
            
            // Mocking historical data for trend observations
            if let yesterday = Calendar.current.date(byAdding: .day, value: -1, to: Date()) {
                self.pastReflections = [
                    DailyReflection(
                        date: yesterday,
                        userNotes: "A bit tired today, didn't sleep well.",
                        overallMood: .poor,
                        insights: ReflectionInsight.mockData,
                        patterns: BehaviorPattern.mockData
                    )
                ]
            }
            
        } catch {
            self.errorMessage = "Failed to load reflection data: \(error.localizedDescription)"
        }
        
        isLoading = false
    }
    
    // MARK: - User Actions
    
    /// Updates the user's mood rating for the current day
    public func updateMood(_ newMood: DailyReflection.MoodRating) {
        guard let current = currentReflection else { return }
        self.currentReflection = DailyReflection(
            id: current.id,
            date: current.date,
            userNotes: current.userNotes,
            overallMood: newMood,
            insights: current.insights,
            patterns: current.patterns
        )
    }
    
    /// Updates the user's personal journal notes
    public func updateNotes(_ notes: String) {
        guard let current = currentReflection else { return }
        self.currentReflection = DailyReflection(
            id: current.id,
            date: current.date,
            userNotes: notes,
            overallMood: current.overallMood,
            insights: current.insights,
            patterns: current.patterns
        )
    }
}
