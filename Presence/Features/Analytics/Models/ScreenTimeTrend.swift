import Foundation

/// Represents digital consumption metrics
public struct ScreenTimeTrend: TrendDataPoint, Equatable {
    public let id: UUID
    public let date: Date
    public let totalHours: Double
    public let socialMediaHours: Double
    public let productivityHours: Double
    
    public init(id: UUID = UUID(), date: Date, totalHours: Double, socialMediaHours: Double, productivityHours: Double) {
        self.id = id
        self.date = date
        self.totalHours = totalHours
        self.socialMediaHours = socialMediaHours
        self.productivityHours = productivityHours
    }
}
