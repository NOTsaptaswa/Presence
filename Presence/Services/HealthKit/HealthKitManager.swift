import Foundation
import HealthKit
import SwiftUI

/// Core manager for HealthKit authorization and orchestration
@Observable
public final class HealthKitManager {
    public static let shared = HealthKitManager()
    
    public let healthStore = HKHealthStore()
    public var isAuthorized = false
    public var authorizationError: String?
    
    private init() {}
    
    // MARK: - Authorization
    
    /// Prompts the user for HealthKit permissions if not already granted.
    @MainActor
    public func requestAuthorization() async {
        guard HKHealthStore.isHealthDataAvailable() else {
            authorizationError = "HealthKit is not available on this device."
            return
        }
        
        do {
            try await healthStore.requestAuthorization(
                toShare: HealthPermissions.writeTypes,
                read: HealthPermissions.readTypes
            )
            isAuthorized = true
            authorizationError = nil
        } catch {
            isAuthorized = false
            authorizationError = error.localizedDescription
        }
    }
}
