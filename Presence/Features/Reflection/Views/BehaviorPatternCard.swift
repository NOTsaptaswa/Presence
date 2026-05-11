import SwiftUI

public struct BehaviorPatternCard: View {
    let pattern: BehaviorPattern
    
    public init(pattern: BehaviorPattern) {
        self.pattern = pattern
    }
    
    private var iconName: String {
        switch pattern.category {
        case .sleep: return "moon.stars.fill"
        case .focus: return "brain.head.profile"
        case .recovery: return "heart.text.square.fill"
        case .screenTime: return "iphone"
        case .general: return "chart.bar.fill"
        }
    }
    
    private var impactColor: Color {
        if pattern.impactScore > 0 { return .green }
        if pattern.impactScore < 0 { return .orange }
        return .secondary
    }
    
    public var body: some View {
        HStack(alignment: .top, spacing: 16) {
            Circle()
                .fill(impactColor.opacity(0.15))
                .frame(width: 44, height: 44)
                .overlay(
                    Image(systemName: iconName)
                        .font(.system(size: 18, weight: .semibold))
                        .foregroundStyle(impactColor)
                )
            
            VStack(alignment: .leading, spacing: 6) {
                Text(pattern.title)
                    .font(Typography.headline)
                    .foregroundStyle(.primary)
                
                Text(pattern.description)
                    .font(Typography.subheadline)
                    .foregroundStyle(AppColors.secondaryText)
                    .fixedSize(horizontal: false, vertical: true)
            }
            Spacer()
        }
        .padding(22)
        .frame(maxWidth: .infinity, alignment: .leading)
        .background(.ultraThinMaterial)
        .clipShape(RoundedRectangle(cornerRadius: AppRadius.card))
    }
}
