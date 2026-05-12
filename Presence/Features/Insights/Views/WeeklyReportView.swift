//
//  WeeklyReportView.swift
//  Presence
//
//  A comprehensive summary of behavioral patterns and consistency scores.
//

import SwiftUI

public struct WeeklyReportView: View {
    
    public var body: some View {
        ZStack {
            AmbientBackgroundView()
            
            MotionScrollView {
                VStack(spacing: 32) {
                    
                    // MARK: - Header
                    VStack(alignment: .leading, spacing: 8) {
                        Text("Weekly Intelligence")
                            .font(.system(size: 34, weight: .bold, design: .rounded))
                            .foregroundStyle(.primary)
                        
                        Text("May 4 – May 10, 2026")
                            .font(.headline)
                            .foregroundStyle(AppColors.secondaryText)
                    }
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .appearAnimation(delay: 0.1, from: .up)
                    
                    // MARK: - Consistency Score
                    VStack(spacing: 16) {
                        Text("Behavioral Consistency")
                            .font(.subheadline.weight(.semibold))
                            .foregroundStyle(AppColors.secondaryText)
                        
                        Text("88%")
                            .font(.system(size: 72, weight: .thin, design: .rounded))
                            .foregroundStyle(.primary)
                        
                        Text("Excellent stability across sleep and focus windows.")
                            .font(.caption)
                            .foregroundStyle(AppColors.secondaryText)
                    }
                    .padding(32)
                    .frame(maxWidth: .infinity)
                    .background(.ultraThinMaterial)
                    .clipShape(RoundedRectangle(cornerRadius: 32, style: .continuous))
                    .floatingCardAppear(delay: 0.2)
                    
                    // MARK: - Key Observations
                    VStack(alignment: .leading, spacing: 20) {
                        Text("Key Observations")
                            .font(.system(size: 14, weight: .bold, design: .rounded))
                            .foregroundStyle(AppColors.secondaryText)
                            .tracking(1.0)
                        
                        InsightCard(insight: BehavioralInsight(
                            title: "Morning Momentum",
                            message: "You are 24% more likely to reach your focus goals on days where you exercise before 9:00 AM.",
                            category: .focus,
                            priority: .positive
                        ))
                        .staggeredAppear(index: 0)
                        
                        InsightCard(insight: BehavioralInsight(
                            title: "Screen Time Impact",
                            message: "High evening screen time (3h+) correlates with a 15% decrease in next-day recovery scores.",
                            category: .screenTime,
                            priority: .warning
                        ))
                        .staggeredAppear(index: 1)
                    }
                }
                .padding(AppSpacing.screenPadding)
            }
        }
    }
}

#Preview {
    WeeklyReportView()
        .preferredColorScheme(.dark)
}
