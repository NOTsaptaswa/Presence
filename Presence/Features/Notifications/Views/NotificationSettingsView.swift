//
//  NotificationSettingsView.swift
//  Presence
//
//  Detailed notification preferences within the Settings flow.
//

import SwiftUI

public struct NotificationSettingsView: View {
    @State private var manager = NotificationManager.shared
    
    // Persistent preferences
    @AppStorage("notif.reflection.enabled") private var reflectionEnabled = true
    @AppStorage("notif.sleep.enabled") private var sleepEnabled = true
    @AppStorage("notif.recovery.enabled") private var recoveryEnabled = true
    @AppStorage("notif.focus.enabled") private var focusEnabled = true
    @AppStorage("notif.reflection.hour") private var reflectionHour = 21
    @AppStorage("notif.reflection.minute") private var reflectionMinute = 0
    
    public init() {}
    
    public var body: some View {
        ZStack {
            AmbientBackgroundView()
            
            MotionScrollView {
                VStack(spacing: 32) {
                    
                    // MARK: - Core Nudges
                    settingsSection(title: "Behavioral Nudges") {
                        VStack(spacing: 12) {
                            ToggleRow(
                                icon: "moon.zzz.fill",
                                title: "Sleep Consistency",
                                isOn: $sleepEnabled
                            )
                            
                            ToggleRow(
                                icon: "heart.text.square.fill",
                                title: "Recovery Alerts",
                                isOn: $recoveryEnabled
                            )
                            
                            ToggleRow(
                                icon: "brain.head.profile",
                                title: "Focus Momentum",
                                isOn: $focusEnabled
                            )
                        }
                        .padding(.vertical, 8)
                    }
                    
                    // MARK: - Daily Reflection
                    settingsSection(title: "Daily Reflection") {
                        VStack(spacing: 16) {
                            ToggleRow(
                                icon: "pencil.and.outline",
                                title: "Evening Reminder",
                                isOn: $reflectionEnabled
                            )
                            
                            if reflectionEnabled {
                                DatePicker(
                                    "Reminder Time",
                                    selection: reflectionTimeBinding(),
                                    displayedComponents: .hourAndMinute
                                )
                                .tint(.primary)
                                .padding(.vertical, 8)
                                .transition(.move(edge: .top).combined(with: .opacity))
                            }
                        }
                        .padding(.vertical, 8)
                    }
                    
                    // MARK: - Info
                    VStack(spacing: 12) {
                        Text("Presence nudges are designed to be subtle and non-invasive. They only trigger when significant behavioral shifts are detected.")
                            .font(.caption)
                            .foregroundStyle(AppColors.secondaryText)
                            .multilineTextAlignment(.center)
                            .padding(.horizontal, 20)
                    }
                    .padding(.top, 8)
                }
                .padding(AppSpacing.screenPadding)
            }
        }
        .navigationTitle("Notifications")
        .navigationBarTitleDisplayMode(.inline)
        .onChange(of: reflectionEnabled) { _, _ in updateSchedules() }
        .onChange(of: reflectionHour) { _, _ in updateSchedules() }
        .onChange(of: reflectionMinute) { _, _ in updateSchedules() }
    }
    
    // MARK: - Helpers
    
    private func reflectionTimeBinding() -> Binding<Date> {
        Binding(
            get: {
                Calendar.current.date(bySettingHour: reflectionHour, minute: reflectionMinute, second: 0, of: Date()) ?? Date()
            },
            set: { newDate in
                let components = Calendar.current.dateComponents([.hour, .minute], from: newDate)
                reflectionHour = components.hour ?? 21
                reflectionMinute = components.minute ?? 0
            }
        )
    }
    
    private func updateSchedules() {
        Task {
            if reflectionEnabled {
                await NotificationScheduler.shared.scheduleReflectionReminder(at: reflectionHour, minute: reflectionMinute)
            } else {
                NotificationManager.shared.cancelAllNotifications(for: .reflection)
            }
        }
    }
    
    private func settingsSection<Content: View>(
        title: String,
        @ViewBuilder content: () -> Content
    ) -> some View {
        VStack(alignment: .leading, spacing: 12) {
            Text(title.uppercased())
                .font(.system(size: 12, weight: .bold, design: .rounded))
                .foregroundStyle(AppColors.secondaryText)
                .tracking(1.0)
                .padding(.leading, 4)
            
            VStack(spacing: 0) {
                content()
            }
            .padding(.horizontal, 16)
            .background(.ultraThinMaterial)
            .clipShape(RoundedRectangle(cornerRadius: 16, style: .continuous))
        }
    }
}

struct ToggleRow: View {
    let icon: String
    let title: String
    @Binding var isOn: Bool
    
    var body: some View {
        Toggle(isOn: $isOn) {
            HStack(spacing: 16) {
                Image(systemName: icon)
                    .font(.system(size: 18))
                    .foregroundStyle(.primary)
                    .frame(width: 32, height: 32)
                    .background(.ultraThinMaterial)
                    .clipShape(RoundedRectangle(cornerRadius: 8, style: .continuous))
                
                Text(title)
                    .font(.system(size: 16, weight: .medium))
                    .foregroundStyle(.primary)
            }
        }
        .padding(.vertical, 8)
        .tint(.primary)
    }
}

#Preview {
    NavigationStack {
        NotificationSettingsView()
    }
    .preferredColorScheme(.dark)
}
