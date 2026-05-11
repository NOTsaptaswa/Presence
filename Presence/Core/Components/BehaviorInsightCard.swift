import SwiftUI

/// A reusable, premium Apple-style card for displaying a behavioral insight.
/// Resembles the minimal, translucent cards found in Apple Health and Journal.
public struct BehaviorInsightCard: View {
    let insight: BehaviorInsight
    
    public init(insight: BehaviorInsight) {
        self.insight = insight
    }
    
    // Maps the insight category to a standard SF Symbol
    private var iconName: String {
        switch insight.category {
        case .recovery: return "heart.text.square.fill"
        case .focus: return "brain.head.profile"
        case .sleep: return "moon.zzz.fill"
        case .screenTime: return "iphone"
        case .correlation: return "arrow.left.and.right"
        }
    }
    
    public var body: some View {
        VStack(alignment: .leading, spacing: 14) {
            // MARK: Header
            HStack(alignment: .top, spacing: 12) {
                Image(systemName: iconName)
                    .font(.title2)
                    .foregroundStyle(insight.severity.color)
                
                VStack(alignment: .leading, spacing: 4) {
                    Text(insight.title)
                        .font(Typography.headline)
                        .foregroundStyle(.primary)
                    
                    // Subtle Severity Indicator Badge
                    HStack(spacing: 4) {
                        Circle()
                            .fill(insight.severity.color)
                            .frame(width: 6, height: 6)
                        Text(insight.severity.title.uppercased())
                            .font(.system(size: 10, weight: .bold, design: .rounded))
                            .foregroundStyle(insight.severity.color)
                            .tracking(1.0)
                    }
                }
                Spacer()
            }
            
            // MARK: Description
            Text(insight.description)
                .font(Typography.subheadline)
                .foregroundStyle(AppColors.secondaryText)
                .fixedSize(horizontal: false, vertical: true)
                .lineSpacing(4)
            
            // MARK: Optional Suggested Action
            if let action = insight.suggestedAction {
                VStack(spacing: 0) {
                    Divider()
                        .background(Color.white.opacity(0.1))
                        .padding(.vertical, 12)
                    
                    HStack(alignment: .top, spacing: 10) {
                        Image(systemName: "lightbulb.max.fill")
                            .foregroundStyle(.yellow)
                            .font(.system(size: 14))
                            .padding(.top, 2)
                        
                        Text(action)
                            .font(.system(size: 13, weight: .medium, design: .rounded))
                            .foregroundStyle(.primary)
                            .fixedSize(horizontal: false, vertical: true)
                        
                        Spacer()
                    }
                }
            }
        }
        .padding(22)
        .frame(maxWidth: .infinity, alignment: .leading)
        // Native iOS Material rendering, perfectly minimal and performant
        .background(.ultraThinMaterial)
        .clipShape(RoundedRectangle(cornerRadius: AppRadius.card, style: .continuous))
        .contentShape(RoundedRectangle(cornerRadius: AppRadius.card))
        .accessibilityElement(children: .combine)
        .accessibilityLabel("\(insight.title), \(insight.severity.title) severity")
        .accessibilityValue(insight.description)
    }
}

// MARK: - Previews

#Preview {
    ZStack {
        AmbientBackgroundView()
        
        ScrollView {
            VStack(spacing: 16) {
                ForEach(BehaviorInsight.mockData) { insight in
                    BehaviorInsightCard(insight: insight)
                }
            }
            .padding()
        }
    }
    .preferredColorScheme(.dark)
}
