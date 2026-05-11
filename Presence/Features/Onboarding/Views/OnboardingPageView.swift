import SwiftUI

/// A reusable view for a single onboarding page.
public struct OnboardingPageView: View {
    let page: OnboardingPage
    
    public init(page: OnboardingPage) {
        self.page = page
    }
    
    public var body: some View {
        VStack(spacing: 32) {
            Spacer()
            
            // Premium Thin Icon
            Image(systemName: page.systemImage)
                .font(.system(size: 80, weight: .thin))
                .foregroundStyle(page.accentColor ?? .primary)
                .symbolEffect(.bounce, options: .nonRepeating)
                .appearAnimation(delay: 0.1, from: .up, distance: 12)
            
            VStack(spacing: 16) {
                Text(page.title)
                    .font(.system(size: 32, weight: .bold, design: .rounded))
                    .foregroundStyle(.primary)
                    .multilineTextAlignment(.center)
                    .appearAnimation(delay: 0.2, from: .up, distance: 10)
                
                Text(page.subtitle)
                    .font(Typography.subheadline)
                    .foregroundStyle(AppColors.secondaryText)
                    .multilineTextAlignment(.center)
                    .padding(.horizontal, 32)
                    .lineSpacing(6)
                    .appearAnimation(delay: 0.3, from: .up, distance: 8)
            }
            
            Spacer()
        }
    }
}
