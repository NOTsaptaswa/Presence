//
//  SettingsView.swift
//  Presence
//
//  Production-ready Settings screen for Presence.
//  Modular, accessible, and fully functional.
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
                            VStack(spacing: 0) {
                                SettingsRow(
                                    icon: "heart.fill",
                                    iconColor: .red,
                                    title: "Health Permissions",
                                    subtitle: viewModel.healthStatus,
                                    action: { Task { await viewModel.requestHealthAccess() } }
                                )
                                
                                Divider().padding(.leading, 50)
                                
                                SettingsRow(
                                    icon: "iphone.badge.play",
                                    iconColor: .blue,
                                    title: "Screen Time",
                                    subtitle: viewModel.screenTimeStatus,
                                    action: { Task { await viewModel.requestScreenTimeAccess() } }
                                )
                                
                                Divider().padding(.leading, 50)
                                
                                SettingsRow(
                                    icon: "square.and.arrow.up",
                                    iconColor: .green,
                                    title: "Export My Data",
                                    subtitle: "Download behavioral history",
                                    action: viewModel.exportData
                                )
                            }
                        }
                        
                        // MARK: - Appearance
                        settingsSection(title: "Appearance") {
                            HStack {
                                Label {
                                    Text("Theme")
                                        .font(.system(size: 17, weight: .medium))
                                } icon: {
                                    Image(systemName: "paintbrush.fill")
                                        .foregroundStyle(.purple)
                                }
                                
                                Spacer()
                                
                                Picker("Theme", selection: $viewModel.appearance) {
                                    ForEach(AppAppearance.allCases) { appearance in
                                        Text(appearance.rawValue).tag(appearance)
                                    }
                                }
                                .pickerStyle(.menu)
                            }
                            .padding(.vertical, 8)
                        }
                        
                        // MARK: - Notifications
                        settingsSection(title: "Notifications") {
                            NavigationLink {
                                NotificationSettingsView()
                            } label: {
                                SettingsRow(
                                    icon: "bell.fill",
                                    iconColor: .orange,
                                    title: "Alert Preferences",
                                    subtitle: "Manage nudges & reminders",
                                    action: {}
                                )
                            }
                        }
                        
                        // MARK: - Advanced
                        settingsSection(title: "Advanced") {
                            SettingsRow(
                                icon: "arrow.counterclockwise",
                                iconColor: .gray,
                                title: "Reset Onboarding",
                                subtitle: "Restart initial experience",
                                action: viewModel.resetOnboarding
                            )
                        }
                        
                        // MARK: - About
                        VStack(spacing: 12) {
                            Text(viewModel.appVersion)
                                .font(.system(size: 13, weight: .medium, design: .rounded))
                                .foregroundStyle(AppColors.secondaryText)
                            
                            Text("Presence is built with a local-first philosophy. Your behavioral data never leaves your device.")
                                .font(.system(size: 12))
                                .foregroundStyle(AppColors.secondaryText)
                                .multilineTextAlignment(.center)
                                .padding(.horizontal, 40)
                                .opacity(0.7)
                        }
                        .padding(.top, 20)
                        .padding(.bottom, 40)
                    }
                    .padding(AppSpacing.screenPadding)
                }
            }
            .navigationTitle("Settings")
            .navigationBarTitleDisplayMode(.large)
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Button("Done") { dismiss() }
                        .font(.system(size: 17, weight: .semibold, design: .rounded))
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
    }
}

#Preview {
    SettingsView()
        .preferredColorScheme(.dark)
}