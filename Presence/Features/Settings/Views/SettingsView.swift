//
//  SettingsView.swift
//  Presence
//
//  Premium, minimal settings screen for Presence.
//

import SwiftUI

public struct SettingsView: View {
    @State private var viewModel = SettingsViewModel()
    @Environment(\.dismiss) var dismiss
    
    public init() {}
    
    public var body: some View {
        NavigationStack {
            ZStack {
                AmbientBackgroundView()
                
                MotionScrollView {
                    VStack(spacing: 32) {
                        
                        // MARK: - Health & Privacy
                        settingsSection(title: "Privacy & Data") {
                            SettingsRow(
                                icon: "heart.fill",
                                color: .red,
                                title: "Health Permissions",
                                subtitle: "Manage what Presence can see",
                                action: viewModel.openHealthSettings
                            )
                            
                            SettingsRow(
                                icon: "square.and.arrow.up",
                                color: .blue,
                                title: "Export My Data",
                                subtitle: "Download your behavioral history",
                                action: viewModel.exportData
                            )
                        }
                        
                        // MARK: - Appearance
                        settingsSection(title: "Appearance") {
                            VStack(spacing: 0) {
                                HStack {
                                    Label("Theme", systemImage: "paintbrush.fill")
                                        .foregroundStyle(.primary)
                                    Spacer()
                                    Picker("Theme", selection: $viewModel.selectedTheme) {
                                        ForEach(viewModel.themeOptions, id: \.self) {
                                            Text($0)
                                        }
                                    }
                                    .pickerStyle(.menu)
                                    .tint(AppColors.secondaryText)
                                }
                                .padding(.vertical, 14)
                            }
                        }
                        
                        // MARK: - Notifications
                        settingsSection(title: "Notifications") {
                            Toggle(isOn: $viewModel.isNotificationsEnabled) {
                                Label("Daily Reminders", systemImage: "bell.fill")
                                    .foregroundStyle(.primary)
                            }
                            .padding(.vertical, 10)
                            .tint(.purple)
                        }
                        
                        // MARK: - Advanced
                        settingsSection(title: "Development") {
                            SettingsRow(
                                icon: "arrow.counterclockwise",
                                color: .orange,
                                title: "Reset Onboarding",
                                subtitle: "Restarts the first-launch experience",
                                action: viewModel.resetOnboarding
                            )
                        }
                        
                        // MARK: - Footer
                        VStack(spacing: 8) {
                            Text("Presence Version 1.0.0")
                                .font(.caption2)
                                .foregroundStyle(AppColors.secondaryText)
                            
                            Text("Your data never leaves your device.")
                                .font(.caption2)
                                .foregroundStyle(AppColors.secondaryText)
                                .opacity(0.6)
                        }
                        .padding(.top, 20)
                    }
                    .padding(AppSpacing.screenPadding)
                }
            }
            .navigationTitle("Settings")
            .navigationBarTitleDisplayMode(.large)
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Button("Done") {
                        dismiss()
                    }
                    .font(.system(size: 17, weight: .semibold, design: .rounded))
                    .foregroundStyle(.primary)
                }
            }
        }
    }
    
    // MARK: - Helpers
    
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
        .appearAnimation(delay: 0.1)
    }
}

// MARK: - Settings Row Component

struct SettingsRow: View {
    let icon: String
    let color: Color
    let title: String
    let subtitle: String?
    let action: () -> Void
    
    var body: some View {
        Button(action: action) {
            HStack(spacing: 16) {
                Image(systemName: icon)
                    .font(.system(size: 18))
                    .foregroundStyle(.white)
                    .frame(width: 32, height: 32)
                    .background(color.gradient)
                    .clipShape(RoundedRectangle(cornerRadius: 8, style: .continuous))
                
                VStack(alignment: .leading, spacing: 2) {
                    Text(title)
                        .font(.system(size: 16, weight: .medium))
                        .foregroundStyle(.primary)
                    
                    if let subtitle = subtitle {
                        Text(subtitle)
                            .font(.system(size: 13))
                            .foregroundStyle(AppColors.secondaryText)
                    }
                }
                
                Spacer()
                
                Image(systemName: "chevron.right")
                    .font(.system(size: 14, weight: .semibold))
                    .foregroundStyle(AppColors.secondaryText)
                    .opacity(0.5)
            }
            .padding(.vertical, 12)
        }
        .buttonStyle(.plain)
    }
}

// MARK: - Previews

#Preview {
    SettingsView()
        .preferredColorScheme(.dark)
}