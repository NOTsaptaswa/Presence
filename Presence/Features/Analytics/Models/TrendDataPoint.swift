import Foundation

/// Base protocol for all behavioral trend data points
public protocol TrendDataPoint: Identifiable {
    var id: UUID { get }
    var date: Date { get }
}
