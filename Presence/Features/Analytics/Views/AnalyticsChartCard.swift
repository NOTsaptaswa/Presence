import SwiftUI

public struct AnalyticsChartCard<Content: View>: View {
    let title: String
    let subtitle: String?
    let systemImage: String
    let content: Content
    
    public init(
        title: String,
        subtitle: String? = nil,
        systemImage: String,
        @ViewBuilder content: () -> Content
    ) {
        self.title = title
        self.subtitle = subtitle
        self.systemImage = systemImage
        self.content = content()
    }
    
    public var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            HStack {
                Label(title, systemImage: systemImage)
                    .font(Typography.headline)
                    .foregroundStyle(.primary)
                
                Spacer()
                
                if let subtitle {
                    Text(subtitle)
                        .font(Typography.subheadline)
                        .foregroundStyle(AppColors.secondaryText)
                }
            }
            
            // The injected chart/content
            content
                .frame(minHeight: 180)
        }
        .padding(22)
        .background(.ultraThinMaterial)
        .clipShape(
            RoundedRectangle(cornerRadius: AppRadius.card)
        )
    }
}
