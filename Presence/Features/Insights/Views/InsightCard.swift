//
//  InsightCard.swift
//  Presence
//
//  Premium, Apple-style card for displaying AI-generated behavioral insights.
//

import SwiftUI

public struct InsightCard: View {
    let insight: BehavioralInsight
    
    public init(insight: BehavioralInsight) {
        self.insight = insight
    }
    
    public var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            
            // MARK: - Header
            HStack(spacing: 12) {
                ZStack {
                    Circle()
                        .fill(insight.category.color.opacity(0.15))
                        .frame(width: 36, height: 36)
                    
                    Image(systemName: insight.category.icon)
                        .font(.system(size: 16, weight: .semibold))
                        .foregroundStyle(insight.category.color)
                }
                
                VStack(alignment: .leading, spacing: 2) {
                    Text(insight.title)
                        .font(.system(size: 16, weight: .bold, design: .rounded))
                        .foregroundStyle(.primary)
                    
                    Text(insight.priority.rawValue.capitalized)
                        .font(.system(size: 12, weight: .medium))
                        .foregroundStyle(priorityColor.opacity(0.8))
                }
                
                Spacer()
                
                Image(systemName: insight.priority.icon)
                    .font(.system(size: 14))
                    .foregroundStyle(priorityColor)
            }
            
            // MARK: - Message
            Text(insight.message)
                .font(Typography.body)
                .foregroundStyle(.primary)
                .lineSpacing(4)
                .fixedSize(horizontal: false, vertical: true)
        }
        .padding(22)
        .background(.ultraThinMaterial)
        .clipShape(RoundedRectangle(cornerRadius: AppRadius.card, style: .continuous))
        .overlay(
            RoundedRectangle(cornerRadius: AppRadius.card, style: .continuous)
                .stroke(priorityColor.opacity(0.1), lineWidth: 1)
        )
    }
    
    // MARK: - Helpers
    
    private var priorityColor: Color {
        switch insight.priority {
        case .positive: return .green
        case .recommendation: return .blue
        case .warning: return .orange
        case .informational: return .secondary
        }
    }
}

// MARK: - Previews

#Preview("Positive Insight") {
    ZStack {
        AmbientBackgroundView()
        InsightCard(insight: BehavioralInsight(
            title: "Sleep Consistency",
            message: "Your recovery improved by 12% after you anchored your bedtime at 10:30 PM for 3 consecutive days.",
            category: .sleep,
            priority: .positive
        ))
        .padding()
    }
    .preferredColorScheme(.dark)
}

#Preview("Warning Insight") {
    ZStack {
        AmbientBackgroundView()
        InsightCard(insight: BehavioralInsight(
            title: "Recovery Trend",
            message: "A slight decline in recovery stability detected. Consider prioritizing low-intensity activity today.",
            category: .recovery,
            priority: .warning
        ))
        .padding()
    }
    .preferredColorScheme(.dark)
}
