//
//  FadeModifier.swift
//  Presence
//
//  Fade and slide transition modifiers for the Presence animation system.
//

import SwiftUI

// MARK: - Fade In Modifier

/// Applies a fade-in with optional vertical slide on appearance.
/// Triggers once when `isActive` becomes true.
struct FadeInModifier: ViewModifier {
    
    let isActive: Bool
    let delay: Double
    let slideOffset: CGFloat
    
    @Environment(\.accessibilityReduceMotion) var reduceMotion
    @State private var hasAppeared = false
    
    func body(content: Content) -> some View {
        content
            .opacity(hasAppeared ? 1 : 0)
            .offset(y: hasAppeared || reduceMotion ? 0 : slideOffset)
            .animation(
                reduceMotion ? .easeOut(duration: 0.2) : MotionTokens.standardSpring.delay(delay),
                value: hasAppeared
            )
            .onChange(of: isActive) { _, newValue in
                if newValue {
                    hasAppeared = true
                }
            }
            .onAppear {
                if isActive {
                    // Small dispatch to ensure the initial state is rendered first
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.01) {
                        hasAppeared = true
                    }
                }
            }
    }
}

// MARK: - Appear Modifier

/// A simpler appear modifier that fades and slides on first appearance.
/// No external trigger needed — fires automatically on `.onAppear`.
struct AppearModifier: ViewModifier {
    
    let delay: Double
    let slideDirection: SlideDirection
    let distance: CGFloat
    
    @Environment(\.accessibilityReduceMotion) var reduceMotion
    @State private var isVisible = false
    
    enum SlideDirection {
        case up, down, leading, trailing, none
    }
    
    func body(content: Content) -> some View {
        content
            .opacity(isVisible ? 1 : 0)
            .offset(
                x: isVisible || reduceMotion ? 0 : horizontalOffset,
                y: isVisible || reduceMotion ? 0 : verticalOffset
            )
            .animation(
                reduceMotion ? .easeOut(duration: 0.2) : MotionTokens.standardSpring.delay(delay),
                value: isVisible
            )
            .onAppear {
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.01) {
                    isVisible = true
                }
            }
    }
    
    private var verticalOffset: CGFloat {
        switch slideDirection {
        case .up: return distance
        case .down: return -distance
        default: return 0
        }
    }
    
    private var horizontalOffset: CGFloat {
        switch slideDirection {
        case .trailing: return distance
        case .leading: return -distance
        default: return 0
        }
    }
}

// MARK: - Staggered Appear Modifier

/// Applies a staggered fade-in animation based on an item's index.
/// Use inside `ForEach` to create cascading entrance effects.
struct StaggeredAppearModifier: ViewModifier {
    
    let index: Int
    let staggerInterval: Double
    
    @Environment(\.accessibilityReduceMotion) var reduceMotion
    @State private var isVisible = false
    
    func body(content: Content) -> some View {
        content
            .opacity(isVisible ? 1 : 0)
            .offset(y: isVisible || reduceMotion ? 0 : MotionTokens.slideUpOffset)
            .scaleEffect(isVisible || reduceMotion ? 1 : 0.97, anchor: .bottom)
            .animation(
                reduceMotion ? .easeOut(duration: 0.2) : MotionTokens.floatingSpring.delay(Double(index) * staggerInterval),
                value: isVisible
            )
            .onAppear {
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.01) {
                    isVisible = true
                }
            }
    }
}

// MARK: - View Extensions

extension View {
    
    /// Fades the view in with a vertical slide when `isActive` becomes `true`.
    /// - Parameters:
    ///   - isActive: Trigger for the animation.
    ///   - delay: Delay before starting (default: 0).
    ///   - slideOffset: Vertical distance to slide (default: 16pt up).
    func fadeIn(
        when isActive: Bool = true,
        delay: Double = 0,
        slideOffset: CGFloat = MotionTokens.slideUpOffset
    ) -> some View {
        modifier(
            FadeInModifier(
                isActive: isActive,
                delay: delay,
                slideOffset: slideOffset
            )
        )
    }
    
    /// Automatically fades and slides the view on first appearance.
    /// - Parameters:
    ///   - delay: Delay before animating (default: 0).
    ///   - from: Direction the view slides from (default: `.up`).
    ///   - distance: Slide distance in points (default: 16pt).
    func appearAnimation(
        delay: Double = 0,
        from direction: AppearModifier.SlideDirection = .up,
        distance: CGFloat = MotionTokens.slideUpOffset
    ) -> some View {
        modifier(
            AppearModifier(
                delay: delay,
                slideDirection: direction,
                distance: distance
            )
        )
    }
    
    /// Staggers this view's entrance based on its index in a list.
    /// - Parameters:
    ///   - index: The item's position in the list.
    ///   - interval: Time between each stagger step (default: 0.06s).
    func staggeredAppear(
        index: Int,
        interval: Double = 0.06
    ) -> some View {
        modifier(
            StaggeredAppearModifier(
                index: index,
                staggerInterval: interval
            )
        )
    }
}
