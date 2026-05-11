import Foundation
import SwiftData

// MARK: - Analytics Persistence Service

/// Modular service for managing CRUD operations on Analytics-related SwiftData models.
/// Designed for high-frequency writes and optimized querying of behavioral tracking data.
@MainActor
public final class AnalyticsPersistenceService {
    
    private let modelContext: ModelContext
    
    public init(modelContext: ModelContext) {
        self.modelContext = modelContext
    }
    
    // MARK: - Create Operations
    
    /// Inserts a new aggregated analytics snapshot.
    public func addSnapshot(_ snapshot: AnalyticsSnapshot) {
        modelContext.insert(snapshot)
        save()
    }
    
    // MARK: - Read Operations
    
    /// Retrieves all historical analytics snapshots, ordered newest to oldest.
    public func fetchAllSnapshots() throws -> [AnalyticsSnapshot] {
        let descriptor = FetchDescriptor<AnalyticsSnapshot>(sortBy: [SortDescriptor(\.date, order: .reverse)])
        return try modelContext.fetch(descriptor)
    }
    
    /// Retrieves a sequential array of snapshots within a specific date boundary for charting.
    public func fetchSnapshots(from startDate: Date, to endDate: Date) throws -> [AnalyticsSnapshot] {
        let descriptor = FetchDescriptor<AnalyticsSnapshot>(
            predicate: #Predicate<AnalyticsSnapshot> { snapshot in
                snapshot.date >= startDate && snapshot.date <= endDate
            },
            sortBy: [SortDescriptor(\.date, order: .forward)]
        )
        return try modelContext.fetch(descriptor)
    }
    
    // MARK: - Update Operations
    
    /// Commits any active context modifications to disk.
    public func save() {
        if modelContext.hasChanges {
            do {
                try modelContext.save()
            } catch {
                print("Failed to save Analytics Context: \(error.localizedDescription)")
            }
        }
    }
    
    // MARK: - Delete Operations
    
    /// Removes a snapshot from persistent storage.
    public func deleteSnapshot(_ snapshot: AnalyticsSnapshot) {
        modelContext.delete(snapshot)
        save()
    }
}
