import SwiftUI
import Charts

public struct AnalyticsDashboardView: View {
    @State private var viewModel = AnalyticsViewModel()
    
    public init() {}
    
    public var body: some View {
        ZStack {
            AmbientBackgroundView()
            
            MotionScrollView {
                VStack(spacing: 24) {
                    if viewModel.isLoading {
                        AnalyticsLoadingView()
                    } else if let errorMessage = viewModel.errorMessage {
                        Text(errorMessage)
                            .foregroundStyle(.red)
                            .padding()
                    } else if viewModel.dashboardData == nil {
                        EmptyStateView.noAnalytics()
                            .padding(.top, 60)
                    } else {
                        // Summary Hero section
                        summarySection
                        
                        // Charts Section
                        chartsSection
                    }
                }
                .padding(.horizontal)
                .padding(.top, 24)
                .padding(.bottom, 100)
            }
        }
        .task {
            if viewModel.dashboardData == nil {
                await viewModel.loadAnalyticsData()
            }
        }
    }
    
    // MARK: - Subviews
    
    private var summarySection: some View {
        HStack(spacing: 16) {
            MetricCard(
                title: "Recovery",
                value: "\(viewModel.dashboardData?.latestRecoveryScore ?? 0)",
                systemImage: "heart.text.square.fill"
            )
            .staggeredAppear(index: 0, interval: 0.08)
            
            MetricCard(
                title: "Avg Sleep",
                value: String(format: "%.1fh", viewModel.dashboardData?.averageSleepDuration ?? 0),
                systemImage: "moon.zzz.fill"
            )
            .staggeredAppear(index: 1, interval: 0.08)
        }
    }
    
    private var chartsSection: some View {
        VStack(spacing: 20) {
            // Recovery Chart
            AnalyticsChartCard(
                title: "Recovery Trends",
                subtitle: "Past 7 days",
                systemImage: "waveform.path.ecg"
            ) {
                RecoveryChartView(trends: viewModel.recoveryTrends)
            }
            .floatingCardAppear(delay: 0.15)
            
            // Sleep Chart
            AnalyticsChartCard(
                title: "Sleep Quality",
                subtitle: "Past 7 days",
                systemImage: "bed.double.fill"
            ) {
                Chart(viewModel.sleepTrends) { trend in
                    BarMark(
                        x: .value("Date", trend.date, unit: .day),
                        y: .value("Quality", trend.qualityScore)
                    )
                    .foregroundStyle(Color.indigo.gradient)
                    .cornerRadius(4)
                }
                .chartYScale(domain: 0...100)
                .chartXAxis {
                    AxisMarks(values: .stride(by: .day)) { _ in
                        AxisGridLine()
                        AxisValueLabel(format: .dateTime.weekday(.abbreviated))
                    }
                }
            }
            .floatingCardAppear(delay: 0.25)
            
            // Focus Chart
            AnalyticsChartCard(
                title: "Flow State",
                subtitle: "Past 7 days",
                systemImage: "brain.head.profile"
            ) {
                Chart(viewModel.focusTrends) { trend in
                    LineMark(
                        x: .value("Date", trend.date, unit: .day),
                        y: .value("Flow", trend.flowStateScore)
                    )
                    .foregroundStyle(Color.purple.gradient)
                    .interpolationMethod(.monotone)
                    .symbol(Circle())
                }
                .chartYScale(domain: 0...100)
                .chartXAxis {
                    AxisMarks(values: .stride(by: .day)) { _ in
                        AxisGridLine()
                        AxisValueLabel(format: .dateTime.weekday(.abbreviated))
                    }
                }
            }
            .floatingCardAppear(delay: 0.35)
        }
    }
}

#Preview {
    AnalyticsDashboardView()
}
