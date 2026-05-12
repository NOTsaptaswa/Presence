import Foundation
import SwiftUI

/// Manages the state and progression of the onboarding flow.
@Observable
public final class OnboardingViewModel {
    
    // MARK: - Properties
    
    /// The sequence of pages to display
    public let pages: [OnboardingPage]
    
    /// The index of the currently visible page
    public var currentPageIndex: Int = 0
    
    /// Indicates whether the onboarding flow has been completed by the user
    public var hasCompletedOnboarding: Bool = false
    
    // MARK: - Computed Properties
    
    /// Checks if the user is on the final slide
    public var isLastPage: Bool {
        currentPageIndex == pages.count - 1
    }
    
    /// Safely returns the currently active page model
    public var currentPage: OnboardingPage {
        pages[currentPageIndex]
    }
    
    // MARK: - Initialization
    
    public init(pages: [OnboardingPage] = OnboardingPage.standardFlow) {
        self.pages = pages
    }
    
    // MARK: - Actions
    
    /// Advances to the next page, or completes the flow if at the end.
    public func advancePage() {
        if isLastPage {
            completeOnboarding()
        } else {
            withAnimation(.spring(response: 0.5, dampingFraction: 0.85)) {
                currentPageIndex += 1
            }
        }
    }
    
    /// Flags the onboarding process as finished.
    public func completeOnboarding() {
        // Persist the state through the central service
        SettingsService.shared.isOnboardingComplete = true
        
        withAnimation {
            hasCompletedOnboarding = true
        }
    }
}
