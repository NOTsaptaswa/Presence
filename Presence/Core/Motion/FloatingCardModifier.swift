//
//  FloatingCardModifier.swift
//  Presence
//
//  Floating card entrance animation for the Presence animation system.
//  Creates a subtle lift-and-fade effect resembling Apple's card presentations.
//

import SwiftUI

// MARK: - Floating Card Modifier

/// Applies a floating entrance animation: the view rises from below
/// with a fade, slight scale, and spring motion — like a card lifting
/// off a surface.
struct FloatingCardModifier: ViewModifier {
    
    let delay: Double
    let offsetDistance: CGFloat
    
    @State private var isPresented = false
    
    func body(content: Content) -> some View {
        content
            .opacity(isPresented ? 1 : 0)
            .offset(y: isPresented ? 0 : offsetDistance)
            .scaleEffect(isPresented ? 1 : 0.97)
            .animation(
                MotionTokens.floatingSpring.delay(delay),
                value: isPresented
            )
            .onAppear {
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.01) {
                    isPresented = true
                }
            }
    }
}

// MARK: - Floating Card Dismiss Modifier

/// Supports both entrance and exit for cards that can be dismissed.
/// Binds to an external `isPresented` state for full lifecycle control.
struct FloatingCardLifecycleModifier: ViewModifier {
    
    @Binding var isPresented: Bool
    let offsetDistance: CGFloat
    
    func body(content: Content) -> some View {
        content
            .opacity(isPresented ? 1 : 0)
            .offset(y: isPresented ? 0 : offsetDistance)
            .scaleEffect(isPresented ? 1 : 0.97)
            .animation(MotionTokens.floatingSpring, value: isPresented)
    }
}

// MARK: - View Extensions

extension View {
    
    /// Applies a floating card entrance animation on appearance.
    /// - Parameters:
    ///   - delay: Delay before starting (default: 0).
    ///   - offset: Distance to rise from (default: 24pt).
    func floatingCardAppear(
        delay: Double = 0,
        offset: CGFloat = MotionTokens.floatingCardOffset
    ) -> some View {
        modifier(
            FloatingCardModifier(
                delay: delay,
                offsetDistance: offset
            )
        )
    }
    
    /// Applies a floating card animation bound to external state,
    /// supporting both entrance and dismissal.
    /// - Parameters:
    ///   - isPresented: Binding controlling visibility.
    ///   - offset: Distance for the float (default: 24pt).
    func floatingCard(
        isPresented: Binding<Bool>,
        offset: CGFloat = MotionTokens.floatingCardOffset
    ) -> some View {
        modifier(
            FloatingCardLifecycleModifier(
                isPresented: isPresented,
                offsetDistance: offset
            )
        )
    }
}
