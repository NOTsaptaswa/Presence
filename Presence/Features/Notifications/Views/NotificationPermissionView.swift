//
//  NotificationPermissionView.swift
//  Presence
//
//  Premium onboarding view for requesting notification permissions.
//  Follows Apple's "Health" and "Journal" design language.
//

import SwiftUI

public struct NotificationPermissionView: View {
    @State private var manager = NotificationManager.shared
    var onComplete: () -> Void
    
    public var body: some View {
        ZStack {
            AmbientBackgroundView()
            
            VStack(spacing: 32) {
                Spacer()
                
                // MARK: - Header
                VStack(spacing: 16) {
                    Image(systemName: "bell.badge.fill")
                        .font(.system(size: 60, weight: .thin))
                        .foregroundStyle(.primary)
                        .appearAnimation(delay: 0.1, from: .up)
                    
                    Text("Stay Present")
                        .font(.system(size: 32, weight: .bold, design: .rounded))
                        .foregroundStyle(.primary)
                        .appearAnimation(delay: 0.2, from: .up)
                    
                    Text("Presence uses subtle behavioral nudges to help you maintain focus and recovery balance.")
                        .font(Typography.body)
                        .foregroundStyle(AppColors.secondaryText)
                        .multilineTextAlignment(.center)
                        .padding(.horizontal, 40)
                        .appearAnimation(delay: 0.3, from: .up)
                }
                
                // MARK: - Feature List
                VStack(alignment: .leading, spacing: 24) {
                    PermissionFeatureRow(
                        icon: "moon.stars.fill",
                        title: "Sleep Continuity",
                        description: "Gentle alerts when your sleep window shifts."
                    )
                    .appearAnimation(delay: 0.4)
                    
                    PermissionFeatureRow(
                        icon: "brain.head.profile",
                        title: "Focus Momentum",
                        description: "Nudges to protect your peak productivity."
                    )
                    .appearAnimation(delay: 0.5)
                    
                    PermissionFeatureRow(
                        icon: "heart.text.square.fill",
                        title: "Recovery Balance",
                        description: "Insights when your body needs rest."
                    )
                    .appearAnimation(delay: 0.6)
                }
                .padding(.horizontal, 24)
                
                Spacer()
                
                // MARK: - Actions
                VStack(spacing: 16) {
                    Button {
                        Task {
                            await manager.requestAuthorization()
                            onComplete()
                        }
                    } label: {
                        Text("Enable Notifications")
                            .font(.headline)
                            .foregroundStyle(.black)
                            .frame(maxWidth: .infinity)
                            .padding(.vertical, 18)
                            .background(Color.white)
                            .clipShape(Capsule())
                    }
                    .pressableStyle()
                    .appearAnimation(delay: 0.7, from: .down)
                    
                    Button("Not Now") {
                        onComplete()
                    }
                    .font(.subheadline.weight(.medium))
                    .foregroundStyle(AppColors.secondaryText)
                    .appearAnimation(delay: 0.8, from: .down)
                }
                .padding(.horizontal, 24)
                .padding(.bottom, 20)
            }
        }
    }
}

// MARK: - Subcomponents

struct PermissionFeatureRow: View {
    let icon: String
    let title: String
    let description: String
    
    var body: some View {
        HStack(spacing: 20) {
            Image(systemName: icon)
                .font(.title2)
                .foregroundStyle(.primary)
                .frame(width: 44, height: 44)
                .background(.ultraThinMaterial)
                .clipShape(RoundedRectangle(cornerRadius: 12, style: .continuous))
            
            VStack(alignment: .leading, spacing: 4) {
                Text(title)
                    .font(.headline)
                    .foregroundStyle(.primary)
                
                Text(description)
                    .font(.subheadline)
                    .foregroundStyle(AppColors.secondaryText)
            }
        }
    }
}

// MARK: - Previews

#Preview {
    NotificationPermissionView {}
        .preferredColorScheme(.dark)
}
