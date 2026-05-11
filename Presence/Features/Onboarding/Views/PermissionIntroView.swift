import SwiftUI

/// The final onboarding view specifically tailored to ask for Apple Health permissions.
public struct PermissionIntroView: View {
    let page: OnboardingPage
    let onContinue: () -> Void
    
    public init(page: OnboardingPage, onContinue: @escaping () -> Void) {
        self.page = page
        self.onContinue = onContinue
    }
    
    public var body: some View {
        VStack(spacing: 32) {
            Spacer()
            
            Image(systemName: page.systemImage)
                .font(.system(size: 80, weight: .thin))
                .foregroundStyle(page.accentColor ?? .primary)
                .appearAnimation(delay: 0.1, from: .up, distance: 12)
            
            VStack(spacing: 16) {
                Text(page.title)
                    .font(.system(size: 32, weight: .bold, design: .rounded))
                    .foregroundStyle(.primary)
                    .multilineTextAlignment(.center)
                    .appearAnimation(delay: 0.18, from: .up, distance: 10)
                
                Text(page.subtitle)
                    .font(Typography.subheadline)
                    .foregroundStyle(AppColors.secondaryText)
                    .multilineTextAlignment(.center)
                    .padding(.horizontal, 32)
                    .lineSpacing(6)
            }
            
            // HealthKit Feature Highlights
            VStack(alignment: .leading, spacing: 22) {
                featureRow(icon: "heart.text.square", title: "Recovery", subtitle: "Resting heart rate and HRV.")
                featureRow(icon: "moon.zzz", title: "Sleep", subtitle: "Sleep duration and quality tracking.")
                featureRow(icon: "figure.walk", title: "Activity", subtitle: "Step counts to correlate with fatigue.")
            }
            .padding(24)
            .background(.ultraThinMaterial)
            .clipShape(RoundedRectangle(cornerRadius: AppRadius.card))
            .floatingCardAppear(delay: 0.3)
            .padding(.horizontal, 24)
            
            Spacer()
            
            Button(action: onContinue) {
                Text("Enable Apple Health")
                    .font(.system(size: 17, weight: .semibold))
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(Color.white)
                    .foregroundStyle(.black)
                    .clipShape(Capsule())
            }
            .padding(.horizontal, 32)
            .padding(.bottom, 40)
            .pressableStyle()
            .appearAnimation(delay: 0.4, from: .up, distance: 10)
        }
    }
    
    private func featureRow(icon: String, title: String, subtitle: String) -> some View {
        HStack(spacing: 16) {
            Image(systemName: icon)
                .font(.title2)
                .foregroundStyle(.green)
                .frame(width: 30)
            
            VStack(alignment: .leading, spacing: 4) {
                Text(title)
                    .font(Typography.headline)
                    .foregroundStyle(.primary)
                Text(subtitle)
                    .font(Typography.subheadline)
                    .foregroundStyle(AppColors.secondaryText)
            }
        }
    }
}
