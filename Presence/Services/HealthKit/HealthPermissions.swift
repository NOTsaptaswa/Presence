import HealthKit

/// Defines the HealthKit read and write permissions for the Presence app.
public enum HealthPermissions {
    
    /// Types of data Presence reads from HealthKit
    public static let readTypes: Set<HKObjectType> = {
        guard let sleepAnalysis = HKObjectType.categoryType(forIdentifier: .sleepAnalysis),
              let heartRate = HKObjectType.quantityType(forIdentifier: .heartRate),
              let restingHeartRate = HKObjectType.quantityType(forIdentifier: .restingHeartRate),
              let hrv = HKObjectType.quantityType(forIdentifier: .heartRateVariabilitySDNN),
              let steps = HKObjectType.quantityType(forIdentifier: .stepCount) else {
            return []
        }
        return [sleepAnalysis, heartRate, restingHeartRate, hrv, steps]
    }()
    
    /// Types of data Presence writes to HealthKit
    public static let writeTypes: Set<HKSampleType> = []
}
