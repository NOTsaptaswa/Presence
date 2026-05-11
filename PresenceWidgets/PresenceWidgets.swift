import WidgetKit
import SwiftUI

// MARK: - Timeline Provider

struct RecoveryProvider: TimelineProvider {
    func placeholder(in context: Context) -> RecoveryEntry {
        RecoveryEntry(date: Date(), recoveryScore: 85, sleepDuration: "7h 20m", insightText: "Optimal recovery. Ready for high focus.")
    }

    func getSnapshot(in context: Context, completion: @escaping (RecoveryEntry) -> Void) {
        let entry = RecoveryEntry(date: Date(), recoveryScore: 85, sleepDuration: "7h 20m", insightText: "Optimal recovery. Ready for high focus.")
        completion(entry)
    }

    func getTimeline(in context: Context, completion: @escaping (Timeline<RecoveryEntry>) -> Void) {
        // In a real integration, you would pull the latest AnalyticsSnapshot from SwiftData
        // For the UI challenge, we use an elegant mock timeline.
        let entry = RecoveryEntry(
            date: Date(),
            recoveryScore: Int.random(in: 60...98),
            sleepDuration: "7h \(Int.random(in: 10...50))m",
            insightText: "Resting heart rate remains perfectly stable. Your recovery is trending positively."
        )
        
        // Refresh widget every hour
        let nextUpdate = Calendar.current.date(byAdding: .hour, value: 1, to: Date())!
        let timeline = Timeline(entries: [entry], policy: .after(nextUpdate))
        completion(timeline)
    }
}

// MARK: - Timeline Entry

struct RecoveryEntry: TimelineEntry {
    let date: Date
    let recoveryScore: Int
    let sleepDuration: String
    let insightText: String
}

// MARK: - Widget View

struct PresenceWidgetsEntryView : View {
    var entry: RecoveryProvider.Entry
    @Environment(\.widgetFamily) var family

    private var recoveryColor: Color {
        if entry.recoveryScore >= 80 { return .green }
        if entry.recoveryScore >= 60 { return .orange }
        return .red
    }

    var body: some View {
        Group {
            switch family {
            case .systemSmall:
                smallView
            default:
                mediumView
            }
        }
    }
    
    // MARK: Small Widget
    
    private var smallView: some View {
        VStack(alignment: .leading, spacing: 8) {
            HStack {
                Image(systemName: "heart.text.square.fill")
                    .foregroundStyle(recoveryColor)
                Text("Recovery")
                    .font(.caption.weight(.semibold))
                    .foregroundStyle(.secondary)
            }
            
            Text("\(entry.recoveryScore)%")
                .font(.system(size: 38, weight: .bold, design: .rounded))
                .foregroundStyle(.white)
                .minimumScaleFactor(0.8)
            
            Spacer()
            
            HStack {
                Image(systemName: "moon.zzz.fill")
                    .foregroundStyle(.indigo)
                Text(entry.sleepDuration)
                    .font(.caption2.weight(.medium))
                    .foregroundStyle(.white)
            }
        }
    }
    
    // MARK: Medium Widget
    
    private var mediumView: some View {
        HStack(spacing: 16) {
            // Left Column (Metrics)
            VStack(alignment: .leading, spacing: 8) {
                HStack {
                    Image(systemName: "heart.text.square.fill")
                        .foregroundStyle(recoveryColor)
                    Text("Recovery")
                        .font(.caption.weight(.semibold))
                        .foregroundStyle(.secondary)
                }
                
                Text("\(entry.recoveryScore)%")
                    .font(.system(size: 44, weight: .bold, design: .rounded))
                    .foregroundStyle(.white)
                
                Spacer()
                
                HStack {
                    Image(systemName: "moon.zzz.fill")
                        .foregroundStyle(.indigo)
                    Text(entry.sleepDuration)
                        .font(.caption.weight(.medium))
                        .foregroundStyle(.white)
                }
            }
            .frame(maxWidth: 120, alignment: .leading)
            
            Divider()
                .background(.white.opacity(0.15))
            
            // Right Column (Insights)
            VStack(alignment: .leading, spacing: 8) {
                HStack {
                    Image(systemName: "sparkles")
                        .foregroundStyle(.purple)
                    Text("Insight")
                        .font(.caption.weight(.semibold))
                        .foregroundStyle(.secondary)
                }
                
                Text(entry.insightText)
                    .font(.subheadline)
                    .foregroundStyle(.white)
                    .lineLimit(4)
                    .fixedSize(horizontal: false, vertical: true)
                
                Spacer()
            }
            .frame(maxWidth: .infinity, alignment: .leading)
        }
    }
}

// MARK: - Widget Configuration

struct PresenceWidgets: Widget {
    let kind: String = "PresenceRecoveryWidget"

    var body: some WidgetConfiguration {
        StaticConfiguration(kind: kind, provider: RecoveryProvider()) { entry in
            PresenceWidgetsEntryView(entry: entry)
                .containerBackground(for: .widget) {
                    ZStack {
                        LinearGradient(
                            colors: [Color(white: 0.1), Color.black],
                            startPoint: .topLeading,
                            endPoint: .bottomTrailing
                        )
                        
                        // Subtle ambient orb glow for glass aesthetic
                        Circle()
                            .fill(
                                (entry.recoveryScore >= 80 ? Color.green : entry.recoveryScore >= 60 ? Color.orange : Color.red).opacity(0.15)
                            )
                            .blur(radius: 40)
                            .padding(-20)
                    }
                }
        }
        .configurationDisplayName("Presence Recovery")
        .description("Track your daily recovery and sleep insights at a glance.")
        .supportedFamilies([.systemSmall, .systemMedium])
    }
}

// MARK: - Previews

#Preview("Small", as: .systemSmall) {
    PresenceWidgets()
} timeline: {
    RecoveryEntry(date: .now, recoveryScore: 92, sleepDuration: "7h 45m", insightText: "Your HRV is exceptionally high today.")
}

#Preview("Medium", as: .systemMedium) {
    PresenceWidgets()
} timeline: {
    RecoveryEntry(date: .now, recoveryScore: 92, sleepDuration: "7h 45m", insightText: "Your HRV is exceptionally high today. You are fully recovered and ready for a deep focus session.")
}
