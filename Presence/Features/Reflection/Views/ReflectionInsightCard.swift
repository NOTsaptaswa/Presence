import SwiftUI

public struct ReflectionInsightCard: View {
    let insight: ReflectionInsight
    
    public init(insight: ReflectionInsight) {
        self.insight = insight
    }
    
    public var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            HStack {
                Image(systemName: "sparkles")
                    .foregroundStyle(AppColors.accent)
                Text(insight.summary)
                    .font(Typography.headline)
                    .foregroundStyle(.primary)
                Spacer()
                if insight.isSystemGenerated {
                    Image(systemName: "cpu")
                        .foregroundStyle(AppColors.secondaryText)
                        .font(.caption)
                }
            }
            
            Text(insight.detailedObservation)
                .font(Typography.subheadline)
                .foregroundStyle(AppColors.secondaryText)
                .fixedSize(horizontal: false, vertical: true)
        }
        .padding(22)
        .frame(maxWidth: .infinity, alignment: .leading)
        .background(.ultraThinMaterial)
        .clipShape(RoundedRectangle(cornerRadius: AppRadius.card))
    }
}
