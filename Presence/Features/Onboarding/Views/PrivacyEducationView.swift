//
//  PrivacyEducationView.swift
//  Presence
//
//  Production-ready privacy education screen.
//  Explains local-first architecture and HealthKit privacy to the user.
//

import SwiftUI

public struct PrivacyEducationView: View {
    var onContinue: () -> Void
    
    public var body: some View {
        ZStack {
            AmbientBackgroundView()
            
            VStack(spacing: 32) {
                Spacer()
                
                // MARK: - Header
                VStack(spacing: 16) {
                    Image(systemName: "lock.shield.fill")
                        .font(.system(size: 60, weight: .thin))
                        .foregroundStyle(.primary)
                        .appearAnimation(delay: 0.1, from: .up)
                    
                    Text("Your Data, Local First")
                        .font(.system(size: 28, weight: .bold, design: .rounded))
                        .multilineTextAlignment(.center)
                        .appearAnimation(delay: 0.2, from: .up)
                    
                    Text("Presence is built with a privacy-first architecture. Your behavioral data never leaves your device.")
                        .font(Typography.body)
                        .foregroundStyle(AppColors.secondaryText)
                        .multilineTextAlignment(.center)
                        .padding(.horizontal, 32)
                        .appearAnimation(delay: 0.3, from: .up)
                }
                
                // MARK: - Privacy Pillars
                VStack(alignment: .leading, spacing: 24) {
                    PrivacyPillarRow(
                        icon: "person.badge.shield.check.fill",
                        title: "No Cloud Tracking",
                        description: "We don't use external servers to process your health or screen time data."
                    )
                    .appearAnimation(delay: 0.4)
                    
                    PrivacyPillarRow(
                        icon: "key.fill",
                        title: "On-Device AI",
                        description: "Our behavioral intelligence engine runs entirely on your local hardware."
                    )
                    .appearAnimation(delay: 0.5)
                    
                    PrivacyPillarRow(
                        icon: "checkmark.shield.fill",
                        title: "HealthKit Encryption",
                        description: "Presence respects all system-level encryption for your medical and activity data."
                    )
                    .appearAnimation(delay: 0.6)
                }
                .padding(.horizontal, 24)
                
                Spacer()
                
                // MARK: - Action
                Button(action: onContinue) {
                    Text("I Understand")
                        .font(.headline)
                        .foregroundStyle(.black)
                        .frame(maxWidth: .infinity)
                        .padding(.vertical, 18)
                        .background(Color.white)
                        .clipShape(Capsule())
                }
                .padding(.horizontal, 24)
                .padding(.bottom, 20)
                .pressableStyle()
                .appearAnimation(delay: 0.7, from: .down)
            }
        }
    }
}

struct PrivacyPillarRow: View {
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
                
                Text(description)
                    .font(.subheadline)
                    .foregroundStyle(AppColors.secondaryText)
            }
        }
    }
}

#Preview {
    PrivacyEducationView {}
        .preferredColorScheme(.dark)
}
