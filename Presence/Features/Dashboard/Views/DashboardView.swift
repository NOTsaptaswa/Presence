//
//  DashboardView.swift
//  Presence
//
//  Created by Saptaswa Nandi on 09/05/26.
//

import SwiftUI

struct DashboardView: View {
    
    @State private var viewModel = DashboardViewModel()
    
    let columns = [
        GridItem(.flexible()),
        GridItem(.flexible())
    ]
    
    var body: some View {
        
        NavigationStack {
            
            MotionScrollView {
                
                VStack(spacing: AppSpacing.sectionSpacing){
                    
                    // MARK: - Header
                    DashboardHeader()
                        .appearAnimation(delay: 0.0, from: .up)
                    
                    if viewModel.isLoading {
                        DashboardLoadingView()
                    } else if viewModel.metrics.isEmpty {
                        EmptyStateView.noHealthData()
                            .padding(.top, 40)
                    } else {
                        // MARK: - Hero Card
                        // Sequenced after header
                        RecoveryHeroCard()
                            .floatingCardAppear(delay: 0.1)
                        
                        // MARK: - Metric Grid
                        // Sequenced after hero card
                        LazyVGrid(columns: columns, spacing: 16) {
                            
                            ForEach(Array(viewModel.metrics.enumerated()), id: \.element.id) { index, metric in
                                
                                MetricCard(
                                    title: metric.title,
                                    value: metric.value,
                                    systemImage: metric.systemImage
                                )
                                // Start staggered sequence after the hero card's appearance (0.1 + base stagger)
                                .staggeredAppear(index: index, interval: 0.06)
                                .animation(.spring(response: 0.5).delay(0.2 + Double(index) * 0.06), value: true)
                            }
                        }
                    }
                }
                .padding(AppSpacing.screenPadding)
            }
            .background {
                AmbientBackgroundView()
            }
            .navigationBarHidden(true)
            .task {
                await viewModel.loadDashboard()
            }
        }
    }
}

#Preview {
    DashboardView()
}
