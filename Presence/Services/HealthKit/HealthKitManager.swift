//
//  HealthKitManager.swift
//  Presence
//
//  Advanced HealthKit manager with async/await support and specialized 
//  behavioral queries for sleep, activity, and heart metrics.
//

import Foundation
import HealthKit
import Observation

@Observable
public final class HealthKitManager {
    public static let shared = HealthKitManager()
    
    public let healthStore = HKHealthStore()
    
    public var authorizationStatus: HKAuthorizationStatus = .notDetermined
    
    private init() {}
    
    // MARK: - Authorization
    
    /// Requests authorization for all Presence-related health types.
    @MainActor
    public func requestAuthorization() async -> Bool {
        guard HKHealthStore.isHealthDataAvailable() else { return false }
        
        do {
            try await healthStore.requestAuthorization(
                toShare: HealthPermissions.writeTypes,
                read: HealthPermissions.readTypes
            )
            return true
        } catch {
            print("❌ HealthKitManager: Authorization failed: \(error.localizedDescription)")
            return false
        }
    }
    
    // MARK: - Generic Queries
    
    /// Fetches the most recent sample for a specific quantity type.
    public func fetchLatestQuantity(for identifier: HKQuantityTypeIdentifier) async throws -> HKQuantitySample? {
        guard let type = HKQuantityType.quantityType(forIdentifier: identifier) else { return nil }
        
        let predicate = HKQuery.predicateForSamples(withStart: .distantPast, end: Date(), options: .strictEndDate)
        let sortDescriptor = NSSortDescriptor(key: HKSampleSortIdentifierStartDate, ascending: false)
        
        return try await withCheckedThrowingContinuation { continuation in
            let query = HKSampleQuery(sampleType: type, predicate: predicate, limit: 1, sortDescriptors: [sortDescriptor]) { _, samples, error in
                if let error = error {
                    continuation.resume(throwing: error)
                    return
                }
                continuation.resume(returning: samples?.first as? HKQuantitySample)
            }
            healthStore.execute(query)
        }
    }
    
    /// Fetches statistics for a quantity type (e.g. daily steps) over a date range.
    public func fetchStatistics(for identifier: HKQuantityTypeIdentifier, from start: Date, to end: Date, options: HKStatisticsOptions = .cumulativeSum) async throws -> HKStatistics? {
        guard let type = HKQuantityType.quantityType(forIdentifier: identifier) else { return nil }
        
        let predicate = HKQuery.predicateForSamples(withStart: start, end: end, options: .strictEndDate)
        
        return try await withCheckedThrowingContinuation { continuation in
            let query = HKStatisticsQuery(quantityType: type, quantitySamplePredicate: predicate, options: options) { _, result, error in
                if let error = error {
                    continuation.resume(throwing: error)
                    return
                }
                continuation.resume(returning: result)
            }
            healthStore.execute(query)
        }
    }
    
    // MARK: - Sleep Queries
    
    /// Fetches sleep analysis samples for a specific date range.
    public func fetchSleepSamples(from start: Date, to end: Date) async throws -> [HKCategorySample] {
        guard let sleepType = HKObjectType.categoryType(forIdentifier: .sleepAnalysis) else { return [] }
        
        let predicate = HKQuery.predicateForSamples(withStart: start, end: end, options: .strictEndDate)
        let sortDescriptor = NSSortDescriptor(key: HKSampleSortIdentifierStartDate, ascending: false)
        
        return try await withCheckedThrowingContinuation { continuation in
            let query = HKSampleQuery(sampleType: sleepType, predicate: predicate, limit: HKObjectQueryNoLimit, sortDescriptors: [sortDescriptor]) { _, samples, error in
                if let error = error {
                    continuation.resume(throwing: error)
                    return
                }
                continuation.resume(returning: samples as? [HKCategorySample] ?? [])
            }
            healthStore.execute(query)
        }
    }
}
