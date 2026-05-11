import SwiftUI

public struct ReflectionDashboardView: View {
    @State private var viewModel = ReflectionViewModel()
    
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
                    } else if viewModel.currentReflection == nil && viewModel.activePatterns.isEmpty && viewModel.activeInsights.isEmpty {
                        EmptyStateView.noReflections {
                            // Action to start a new reflection would go here
                        }
                        .padding(.top, 60)
                    } else {
                        // Main Dashboard Content
                        contentSections
                    }
                }
                .padding(.horizontal)
                .padding(.top, 24)
                .padding(.bottom, 120)
            }
        }
        .task {
            if viewModel.currentReflection == nil {
                await viewModel.loadReflections()
            }
        }
    }
    
    @ViewBuilder
    private var contentSections: some View {
        if let reflection = viewModel.currentReflection {
            DailyReflectionCard(reflection: reflection)
                .floatingCardAppear(delay: 0.1)
        }
        
        if !viewModel.activePatterns.isEmpty {
            VStack(alignment: .leading, spacing: 16) {
                Text("Behavioral Trends")
                    .font(.title3.weight(.semibold))
                    .foregroundStyle(.primary)
                    .appearAnimation(delay: 0.2)
                
                ForEach(Array(viewModel.activePatterns.enumerated()), id: \.element.id) { index, pattern in
                    BehaviorPatternCard(pattern: pattern)
                        .staggeredAppear(index: index)
                }
            }
            .padding(.top, 8)
        }
        
        if !viewModel.activeInsights.isEmpty {
            VStack(alignment: .leading, spacing: 16) {
                Text("Recent Observations")
                    .font(.title3.weight(.semibold))
                    .foregroundStyle(.primary)
                    .appearAnimation(delay: 0.3)
                
                ForEach(Array(viewModel.activeInsights.enumerated()), id: \.element.id) { index, insight in
                    ReflectionInsightCard(insight: insight)
                        .staggeredAppear(index: index)
                }
            }
            .padding(.top, 8)
        }
    }
}

#Preview {
    ReflectionDashboardView()
}
