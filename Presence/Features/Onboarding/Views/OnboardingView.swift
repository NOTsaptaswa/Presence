import SwiftUI

public struct OnboardingView: View {
    @State private var viewModel = OnboardingViewModel()
    @State private var showNotificationOnboarding = false
    @State private var showPrivacyEducation = true
    
    public init() {}
    
    public var body: some View {
        ZStack {
            AmbientBackgroundView()
            
            if showPrivacyEducation {
                PrivacyEducationView {
                    withAnimation(.spring(response: 0.6, dampingFraction: 0.8)) {
                        showPrivacyEducation = false
                    }
                }
                .transition(.fadeSlideUp)
            } else {
                VStack {
                    TabView(selection: $viewModel.currentPageIndex) {
                    ForEach(0..<viewModel.pages.count, id: \.self) { index in
                        let page = viewModel.pages[index]
                        
                        if index == viewModel.pages.count - 1 {
                            // Final page focuses on HealthKit Permission
                            PermissionIntroView(page: page) {
                                Task {
                                    // 1. Request actual HealthKit permissions
                                    await HealthKitManager.shared.requestAuthorization()
                                    
                                    // 2. Move to Notification onboarding
                                    withAnimation(.spring(response: 0.6, dampingFraction: 0.8)) {
                                        showNotificationOnboarding = true
                                    }
                                }
                            }
                            .tag(index)
                        } else {
                            OnboardingPageView(page: page)
                                .tag(index)
                        }
                    }
                }
                .tabViewStyle(.page(indexDisplayMode: .always))
                .animation(MotionTokens.standardSpring, value: viewModel.currentPageIndex)
                
                // Primary Action Button (Only show on standard pages)
                if !viewModel.isLastPage && !showNotificationOnboarding {
                    Button(action: viewModel.advancePage) {
                        Text("Continue")
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
                    .transition(.fadeSlideUp)
                }
                }
            }
            
            if showNotificationOnboarding {
                NotificationPermissionView {
                    viewModel.completeOnboarding()
                }
                .transition(.move(edge: .trailing).combined(with: .opacity))
                .zIndex(10)
            }
        }
    }
}

#Preview {
    OnboardingView()
}
