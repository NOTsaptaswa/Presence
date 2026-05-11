import SwiftUI
import Charts

public struct RecoveryChartView: View {
    let trends: [RecoveryTrend]
    
    public var body: some View {
        Chart(trends) { trend in
            LineMark(
                x: .value("Date", trend.date, unit: .day),
                y: .value("Score", trend.score)
            )
            .foregroundStyle(AppColors.accent.gradient)
            .interpolationMethod(.catmullRom)
            .symbol(Circle())
            
            AreaMark(
                x: .value("Date", trend.date, unit: .day),
                yStart: .value("Min", 0),
                yEnd: .value("Score", trend.score)
            )
            .foregroundStyle(
                LinearGradient(
                    gradient: Gradient(colors: [AppColors.accent.opacity(0.3), .clear]),
                    startPoint: .top,
                    endPoint: .bottom
                )
            )
            .interpolationMethod(.catmullRom)
        }
        .chartYScale(domain: 0...100)
        .chartXAxis {
            AxisMarks(values: .stride(by: .day)) { _ in
                AxisGridLine()
                AxisValueLabel(format: .dateTime.weekday(.abbreviated))
            }
        }
    }
}

#Preview {
    RecoveryChartView(trends: BehavioralDashboardData.mock.recoveryTrends)
        .frame(height: 200)
        .padding()
        .preferredColorScheme(.dark)
}
