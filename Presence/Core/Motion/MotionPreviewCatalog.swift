//
//  MotionPreviewCatalog.swift
//  Presence
//
//  Interactive preview catalog demonstrating
//  every animation in the Presence motion system.
//

import SwiftUI

// MARK: - Motion Preview Catalog

struct MotionPreviewCatalog: View {
    
    @State private var showCard = false
    @State private var showTransitionItem = false
    
    var body: some View {
        ZStack {
            AmbientBackgroundView()
            
            MotionScrollView {
                VStack(spacing: AppSpacing.sectionSpacing) {
                    
                    headerSection
                    fadeSection
                    staggeredSection
                    floatingCardSection
                    buttonStyleSection
                    transitionSection
                    scrollMotionSection
                }
                .padding(AppSpacing.screenPadding)
                .padding(.bottom, 60)
            }
        }
        .preferredColorScheme(.dark)
    }
    
    // MARK: - Header
    
    private var headerSection: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text("Motion System")
                .font(Typography.heroTitle)
                .appearAnimation(delay: 0)
            
            Text("Presence animation catalog")
                .font(Typography.subheadline)
                .foregroundStyle(AppColors.secondaryText)
                .appearAnimation(delay: 0.1)
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding(.top, 20)
    }
    
    // MARK: - Fade Animations
    
    private var fadeSection: some View {
        VStack(alignment: .leading, spacing: AppSpacing.cardSpacing) {
            sectionTitle("Fade & Slide", delay: 0.15)
            
            demoCard(title: "Appear Up", icon: "arrow.up.circle.fill")
                .appearAnimation(delay: 0.2, from: .up)
            
            demoCard(title: "Appear Trailing", icon: "arrow.right.circle.fill")
                .appearAnimation(delay: 0.3, from: .trailing)
        }
    }
    
    // MARK: - Staggered List
    
    private var staggeredSection: some View {
        VStack(alignment: .leading, spacing: AppSpacing.cardSpacing) {
            sectionTitle("Staggered List", delay: 0.35)
            
            ForEach(0..<4, id: \.self) { index in
                demoCard(
                    title: "Item \(index + 1)",
                    icon: "circle.fill"
                )
                .staggeredAppear(index: index, interval: 0.08)
            }
        }
    }
    
    // MARK: - Floating Card
    
    private var floatingCardSection: some View {
        VStack(alignment: .leading, spacing: AppSpacing.cardSpacing) {
            sectionTitle("Floating Card", delay: 0.4)
            
            Button {
                withAnimation(MotionTokens.floatingSpring) {
                    showCard.toggle()
                }
            } label: {
                Label(
                    showCard ? "Dismiss Card" : "Show Card",
                    systemImage: showCard ? "xmark.circle.fill" : "plus.circle.fill"
                )
                .font(.system(size: 15, weight: .semibold, design: .rounded))
                .foregroundStyle(.white)
                .padding(.horizontal, 20)
                .padding(.vertical, 12)
                .background(.ultraThinMaterial)
                .clipShape(Capsule())
            }
            .pressableStyle()
            
            if showCard {
                demoCard(title: "Floating Card", icon: "square.on.square.fill")
                    .transition(.floatingCard)
            }
        }
    }
    
    // MARK: - Button Styles
    
    private var buttonStyleSection: some View {
        VStack(alignment: .leading, spacing: AppSpacing.cardSpacing) {
            sectionTitle("Button Feedback", delay: 0.45)
            
            HStack(spacing: 12) {
                Button("Press") {}
                    .buttonStyle(PressScaleButtonStyle())
                    .modifier(ButtonDemoStyle())
                
                Button("Soft") {}
                    .buttonStyle(SoftPressButtonStyle())
                    .modifier(ButtonDemoStyle())
                
                Button("Bounce") {}
                    .buttonStyle(BounceButtonStyle())
                    .modifier(ButtonDemoStyle())
                
                Button("Glow") {}
                    .buttonStyle(GlowPressButtonStyle())
                    .modifier(ButtonDemoStyle())
            }
            .floatingCardAppear(delay: 0.5)
        }
    }
    
    // MARK: - Transitions
    
    private var transitionSection: some View {
        VStack(alignment: .leading, spacing: AppSpacing.cardSpacing) {
            sectionTitle("Transitions", delay: 0.5)
            
            Button {
                withAnimation(MotionTokens.standardSpring) {
                    showTransitionItem.toggle()
                }
            } label: {
                Label(
                    "Toggle Item",
                    systemImage: "arrow.triangle.2.circlepath"
                )
                .font(.system(size: 15, weight: .semibold, design: .rounded))
                .foregroundStyle(.white)
                .padding(.horizontal, 20)
                .padding(.vertical, 12)
                .background(.ultraThinMaterial)
                .clipShape(Capsule())
            }
            .pressableStyle()
            
            if showTransitionItem {
                demoCard(title: "Fade Flow", icon: "sparkles")
                    .transition(.fadeFlow)
            }
        }
    }
    
    // MARK: - Scroll Motion
    
    private var scrollMotionSection: some View {
        VStack(alignment: .leading, spacing: AppSpacing.cardSpacing) {
            sectionTitle("Scroll Motion", delay: 0.55)
            
            Text("Scroll up and down to see parallax and scale effects on these cards.")
                .font(Typography.subheadline)
                .foregroundStyle(AppColors.secondaryText)
            
            ForEach(0..<3, id: \.self) { i in
                demoCard(
                    title: "Parallax \(i + 1)",
                    icon: "mountain.2.fill"
                )
                .scrollParallax(strength: 0.05)
            }
        }
    }
    
    // MARK: - Helpers
    
    private func sectionTitle(_ title: String, delay: Double) -> some View {
        Text(title)
            .font(.system(size: 13, weight: .bold, design: .rounded))
            .foregroundStyle(AppColors.secondaryText)
            .textCase(.uppercase)
            .tracking(1.2)
            .appearAnimation(delay: delay)
    }
    
    private func demoCard(title: String, icon: String) -> some View {
        HStack(spacing: 14) {
            Image(systemName: icon)
                .font(.title3)
                .foregroundStyle(.white.opacity(0.8))
            
            Text(title)
                .font(Typography.headline)
            
            Spacer()
        }
        .padding(22)
        .frame(maxWidth: .infinity, alignment: .leading)
        .background(.ultraThinMaterial)
        .clipShape(RoundedRectangle(cornerRadius: AppRadius.card, style: .continuous))
    }
}

// MARK: - Button Demo Style

private struct ButtonDemoStyle: ViewModifier {
    func body(content: Content) -> some View {
        content
            .font(.system(size: 13, weight: .semibold, design: .rounded))
            .foregroundStyle(.white)
            .padding(.horizontal, 16)
            .padding(.vertical, 12)
            .frame(maxWidth: .infinity)
            .background(.ultraThinMaterial)
            .clipShape(RoundedRectangle(cornerRadius: 16, style: .continuous))
    }
}

// MARK: - Preview

#Preview("Motion Catalog") {
    MotionPreviewCatalog()
}
