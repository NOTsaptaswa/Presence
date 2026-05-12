//
//  HealthDataService.swift
//  Presence
//
//  Aggregates raw HealthKit data into high-level behavioral metrics.
//  Responsible for calculating consistency and stability scores.
//

import os

public final class HealthDataService {
    public static let shared = HealthDataService()
    
    private let hkManager = HealthKitManager.shared
    private let logger = Logger(subsystem: "com.presence.app", category: "HealthData")
    
    private init() {}
    
    // MARK: - Sleep Processing
    
    /// Calculates sleep duration and consistency for the last 7 days.
    public func getWeeklySleepSummary() async -> WeeklySleepSummary {
        let calendar = Calendar.current
        let end = Date()
        let start = calendar.date(byAdding: .day, value: -7, to: end) ?? end
        
        do {
            logger.info("Fetching weekly sleep samples...")
            let samples = try await hkManager.fetchSleepSamples(from: start, to: end)
            
            let dailyDurations = calculateDailySleepDurations(from: samples)
            let avgDuration = dailyDurations.values.reduce(0, +) / Double(max(dailyDurations.count, 1))
            let consistency = calculateSleepConsistency(from: samples)
            
            logger.info("Weekly sleep summary computed: avg=\(avgDuration), consistency=\(consistency)")
            
            return WeeklySleepSummary(
                averageDuration: avgDuration,
                consistencyScore: consistency,
                dailyDurations: dailyDurations
            )
        } catch {
            logger.error("Failed to fetch sleep summary: \(error.localizedDescription)")
            return .empty
        }
    }
    
    // MARK: - Activity Processing
    
    /// Fetches step count for today.
    public func getTodaySteps() async -> Int {
        let calendar = Calendar.current
        let start = calendar.startOfDay(for: Date())
        
        do {
            let stats = try await hkManager.fetchStatistics(for: .stepCount, from: start, to: Date())
            let steps = Int(stats?.sumQuantity()?.doubleValue(for: .count()) ?? 0)
            logger.debug("Steps fetched: \(steps)")
            return steps
        } catch {
            logger.error("Failed to fetch steps: \(error.localizedDescription)")
            return 0
        }
    }
    
    // MARK: - Heart Processing
    
    /// Fetches the latest HRV and RHR metrics.
    public func getLatestHeartMetrics() async -> (hrv: Double?, rhr: Double?) {
        do {
            let hrvSample = try await hkManager.fetchLatestQuantity(for: .heartRateVariabilitySDNN)
            let rhrSample = try await hkManager.fetchLatestQuantity(for: .restingHeartRate)
            
            let hrv = hrvSample?.quantity.doubleValue(for: .secondUnit(with: .milli))
            let rhr = rhrSample?.quantity.doubleValue(for: .count().unitDivided(by: .minute()))
            
            logger.debug("Heart metrics: HRV=\(hrv ?? 0), RHR=\(rhr ?? 0)")
            return (hrv, rhr)
        } catch {
            logger.error("Failed to fetch heart metrics: \(error.localizedDescription)")
            return (nil, nil)
        }
    }
    
    // MARK: - Private Helpers
    
    private func calculateDailySleepDurations(from samples: [HKCategorySample]) -> [Date: TimeInterval] {
        var durations: [Date: TimeInterval] = [:]
        let calendar = Calendar.current
        
        for sample in samples {
            let day = calendar.startOfDay(for: sample.endDate)
            let duration = sample.endDate.timeIntervalSince(sample.startDate)
            durations[day, default: 0] += duration
        }
        
        return durations
    }
    
    private func calculateSleepConsistency(from samples: [HKCategorySample]) -> Double {
        guard samples.count >= 3 else { return 0.5 } // Not enough data for consistency
        
        // Simplified consistency: Variance in bedtime across samples
        let calendar = Calendar.current
        let bedtimes = samples.map { sample -> Double in
            let components = calendar.dateComponents([.hour, .minute], from: sample.startDate)
            return Double(components.hour ?? 0) + (Double(components.minute ?? 0) / 60.0)
        }
        
        let mean = bedtimes.reduce(0, +) / Double(bedtimes.count)
        let variance = bedtimes.map { pow($0 - mean, 2) }.reduce(0, +) / Double(bedtimes.count)
        
        // Convert variance to a 0.0 - 1.0 score (lower variance = higher consistency)
        // 0 variance = 1.0 score, 4 hours variance = ~0.0 score
        let score = max(0.0, 1.0 - (variance / 4.0))
        return score
    }
}

// MARK: - Supporting Models

public struct WeeklySleepSummary {
    public let averageDuration: TimeInterval
    public let consistencyScore: Double
    public let dailyDurations: [Date: TimeInterval]
    
    static let empty = WeeklySleepSummary(averageDuration: 0, consistencyScore: 0, dailyDurations: [:])
}
