import SwiftUI

public struct DailyReflectionCard: View {
    let reflection: DailyReflection
    
    public init(reflection: DailyReflection) {
        self.reflection = reflection
    }
    
    private var moodIcon: String {
        switch reflection.overallMood {
        case .terrible: return "cloud.rain.fill"
        case .poor: return "cloud.fill"
        case .neutral: return "cloud.sun.fill"
        case .good: return "sun.max.fill"
        case .excellent: return "sparkles"
        }
    }
    
    public var body: some View {
        VStack(alignment: .leading, spacing: 18) {
            HStack {
                Text("Today's Journal")
                    .font(Typography.headline)
                    .foregroundStyle(.primary)
                Spacer()
                Text(reflection.date.formatted(date: .abbreviated, time: .omitted))
                    .font(.caption)
                    .foregroundStyle(AppColors.secondaryText)
            }
            
            HStack(spacing: 12) {
                Image(systemName: moodIcon)
                    .font(.title2)
                    .foregroundStyle(AppColors.accent)
                
                Text(reflection.userNotes ?? "No notes recorded yet.")
                    .font(Typography.subheadline)
                    .foregroundStyle(reflection.userNotes == nil ? AppColors.secondaryText : .primary)
                    .italic(reflection.userNotes == nil)
            }
        }
        .padding(22)
        .frame(maxWidth: .infinity, alignment: .leading)
        .background(.ultraThinMaterial)
        .clipShape(RoundedRectangle(cornerRadius: AppRadius.card))
    }
}
