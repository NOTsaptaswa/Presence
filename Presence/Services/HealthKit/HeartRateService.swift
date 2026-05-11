import Foundation
import HealthKit

/// Service for fetching cardiovascular metrics like Heart Rate, Resting Heart Rate, and HRV
public final class HeartRateService {
    private let healthStore: HKHealthStore
    
    public init(healthStore: HKHealthStore = HealthKitManager.shared.healthStore) {
        self.healthStore = healthStore
    }
    
    // MARK: - Fetching Data
    
    /// Fetches Resting Heart Rate (RHR) samples
    public func fetchRestingHeartRate(for days: Int = 7) async throws -> [HKQuantitySample] {
        guard let rhrType = HKObjectType.quantityType(forIdentifier: .restingHeartRate) else {
            throw HKError(.errorInvalidArgument)
        }
        return try await fetchQuantitySamples(for: rhrType, days: days)
    }
    
    /// Fetches Heart Rate Variability (HRV) samples
    public func fetchHRV(for days: Int = 7) async throws -> [HKQuantitySample] {
        guard let hrvType = HKObjectType.quantityType(forIdentifier: .heartRateVariabilitySDNN) else {
            throw HKError(.errorInvalidArgument)
        }
        return try await fetchQuantitySamples(for: hrvType, days: days)
    }
    
    // MARK: - Core Query Method
    
    private func fetchQuantitySamples(for type: HKQuantityType, days: Int) async throws -> [HKQuantitySample] {
        let calendar = Calendar.current
        let endDate = Date()
        guard let startDate = calendar.date(byAdding: .day, value: -days, to: endDate) else {
            throw HKError(.errorInvalidArgument)
        }
        
        let predicate = HKQuery.predicateForSamples(withStart: startDate, end: endDate, options: .strictEndDate)
        let sortDescriptor = NSSortDescriptor(key: HKSampleSortIdentifierEndDate, ascending: false)
        
        return try await withCheckedThrowingContinuation { continuation in
            let query = HKSampleQuery(
                sampleType: type,
                predicate: predicate,
                limit: HKObjectQueryNoLimit,
                sortDescriptors: [sortDescriptor]
            ) { _, samples, error in
                if let error = error {
                    continuation.resume(throwing: error)
                    return
                }
                
                let quantitySamples = samples as? [HKQuantitySample] ?? []
                continuation.resume(returning: quantitySamples)
            }
            healthStore.execute(query)
        }
    }
}
