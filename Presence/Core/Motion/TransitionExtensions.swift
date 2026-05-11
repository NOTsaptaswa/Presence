//
//  TransitionExtensions.swift
//  Presence
//

import SwiftUI

// MARK: - Custom Transitions

extension AnyTransition {
    
    /// Fade combined with slide-up.
    static var fadeSlideUp: AnyTransition {
        .opacity.combined(with: .offset(y: MotionTokens.slideUpOffset))
    }
    
    /// Fade combined with slide-down.
    static var fadeSlideDown: AnyTransition {
        .opacity.combined(with: .offset(y: -MotionTokens.slideUpOffset))
    }
    
    /// Floating card entrance — fade, scale, and slide.
    static var floatingCard: AnyTransition {
        .opacity
        .combined(with: .scale(scale: 0.97))
        .combined(with: .offset(y: MotionTokens.floatingCardOffset))
    }
    
    /// Subtle pop-in for badges and indicators.
    static var popIn: AnyTransition {
        .opacity.combined(with: .scale(scale: 0.9))
    }
    
    /// Asymmetric: fades up on insert, fades out on removal.
    static var fadeFlow: AnyTransition {
        .asymmetric(insertion: .fadeSlideUp, removal: .opacity)
    }
}
