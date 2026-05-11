import Foundation
import SwiftData

// MARK: - Reflection Persistence Service

/// Modular service for managing CRUD operations on Reflection-related SwiftData models.
/// Designed to be injected into ViewModels using @Environment(\.modelContext).
@MainActor
public final class ReflectionPersistenceService {
    
    private let modelContext: ModelContext
    
    public init(modelContext: ModelContext) {
        self.modelContext = modelContext
    }
    
    // MARK: - Create Operations
    
    /// Adds a new daily ReflectionEntry to the persistent store.
    public func addReflection(_ entry: ReflectionEntry) {
        modelContext.insert(entry)
        save()
    }
    
    /// Adds a new BehaviorSummary and optionally links it to an existing reflection.
    public func addBehaviorSummary(_ summary: BehaviorSummary, to reflection: ReflectionEntry? = nil) {
        modelContext.insert(summary)
        
        if let reflection = reflection {
            summary.reflection = reflection
            if reflection.behaviorSummaries == nil {
                reflection.behaviorSummaries = []
            }
            reflection.behaviorSummaries?.append(summary)
        }
        
        save()
    }
    
    // MARK: - Read Operations
    
    /// Fetches all historical reflections ordered chronologically descending (newest first).
    public func fetchAllReflections() throws -> [ReflectionEntry] {
        let descriptor = FetchDescriptor<ReflectionEntry>(sortBy: [SortDescriptor(\.date, order: .reverse)])
        return try modelContext.fetch(descriptor)
    }
    
    /// Fetches a single reflection entry for a specific calendar day.
    public func fetchReflection(for date: Date) throws -> ReflectionEntry? {
        let calendar = Calendar.current
        let startOfDay = calendar.startOfDay(for: date)
        guard let endOfDay = calendar.date(byAdding: .day, value: 1, to: startOfDay) else { return nil }
        
        let descriptor = FetchDescriptor<ReflectionEntry>(
            predicate: #Predicate<ReflectionEntry> { entry in
                entry.date >= startOfDay && entry.date < endOfDay
            }
        )
        
        return try modelContext.fetch(descriptor).first
    }
    
    // MARK: - Update Operations
    
    /// Commits any pending mutations to the local database.
    public func save() {
        if modelContext.hasChanges {
            do {
                try modelContext.save()
            } catch {
                print("Failed to save Reflection Context: \(error.localizedDescription)")
            }
        }
    }
    
    // MARK: - Delete Operations
    
    /// Permanently deletes a specific reflection and its cascading child data.
    public func deleteReflection(_ entry: ReflectionEntry) {
        modelContext.delete(entry)
        save()
    }
}
