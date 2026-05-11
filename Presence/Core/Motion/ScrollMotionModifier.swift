//
//  ScrollMotionModifier.swift
//  Presence
//
//  Scroll-based motion effects for the Presence animation system.
//  Uses GeometryReader to derive parallax, fade, and scale
//  from a view's scroll position.
//

import SwiftUI

// MARK: - Scroll Fade Modifier

/// Fades a view based on its vertical position within a ScrollView.
/// The view becomes fully opaque as it enters the visible area
/// and fades out as it scrolls away.
struct ScrollFadeModifier: ViewModifier {
    
    let anchor: UnitPoint
    let fadeDistance: CGFloat
    
    func body(content: Content) -> some View {
        content
            .overlay(
                GeometryReader { geometry in
                    Color.clear
                        .preference(
                            key: ScrollOffsetPreferenceKey.self,
                            value: geometry.frame(in: .named("scrollMotion")).minY
                        )
                }
            )
            .onPreferenceChange(ScrollOffsetPreferenceKey.self) { _ in
                // Preference collected — actual opacity set via geometry below
            }
            .modifier(ScrollFadeEffectModifier(fadeDistance: fadeDistance))
    }
}

/// Internal modifier that applies the actual opacity based on geometry.
private struct ScrollFadeEffectModifier: ViewModifier {
    
    let fadeDistance: CGFloat
    
    func body(content: Content) -> some View {
        GeometryReader { geometry in
            let frame = geometry.frame(in: .named("scrollMotion"))
            let screenHeight = UIScreen.main.bounds.height
            
            // Calculate normalized progress (0 = fully off-screen, 1 = fully visible)
            let bottomProgress = min(
                max((screenHeight - frame.minY) / fadeDistance, 0), 1
            )
            let topProgress = min(
                max((frame.maxY) / fadeDistance, 0), 1
            )
            let opacity = min(bottomProgress, topProgress)
            
            content
                .opacity(opacity)
                .frame(width: frame.width, height: frame.height)
        }
    }
}

// MARK: - Scroll Parallax Modifier

/// Applies a subtle parallax offset to a view based on scroll position.
/// Creates depth by moving the view at a different rate than scroll.
struct ScrollParallaxModifier: ViewModifier {
    
    let strength: CGFloat
    let axis: Axis
    
    func body(content: Content) -> some View {
        GeometryReader { geometry in
            let frame = geometry.frame(in: .global)
            let screenMid = UIScreen.main.bounds.height / 2
            let offset = (frame.midY - screenMid) * strength
            
            content
                .offset(
                    x: axis == .horizontal ? offset : 0,
                    y: axis == .vertical ? offset : 0
                )
                .frame(width: frame.width, height: frame.height)
        }
    }
}

// MARK: - Scroll Scale Modifier

/// Subtly scales a view based on its proximity to the center of the screen.
/// Views near the center appear slightly larger, creating a carousel-like depth.
struct ScrollScaleModifier: ViewModifier {
    
    let minScale: CGFloat
    let maxScale: CGFloat
    
    func body(content: Content) -> some View {
        GeometryReader { geometry in
            let frame = geometry.frame(in: .global)
            let screenMid = UIScreen.main.bounds.height / 2
            let distanceFromCenter = abs(frame.midY - screenMid)
            let maxDistance = screenMid
            
            let normalizedDistance = min(distanceFromCenter / maxDistance, 1)
            let scale = maxScale - (maxScale - minScale) * normalizedDistance
            
            content
                .scaleEffect(scale)
                .frame(width: frame.width, height: frame.height)
        }
    }
}

// MARK: - Scroll Offset Preference Key

struct ScrollOffsetPreferenceKey: PreferenceKey {
    static var defaultValue: CGFloat = 0
    static func reduce(value: inout CGFloat, nextValue: () -> CGFloat) {
        value = nextValue()
    }
}

// MARK: - Scroll Motion Coordinate Space

/// Wraps a ScrollView with the required coordinate space for motion effects.
struct MotionScrollView<Content: View>: View {
    
    let axes: Axis.Set
    let showsIndicators: Bool
    @ViewBuilder let content: () -> Content
    
    init(
        _ axes: Axis.Set = .vertical,
        showsIndicators: Bool = false,
        @ViewBuilder content: @escaping () -> Content
    ) {
        self.axes = axes
        self.showsIndicators = showsIndicators
        self.content = content
    }
    
    var body: some View {
        ScrollView(axes, showsIndicators: showsIndicators) {
            content()
        }
        .coordinateSpace(name: "scrollMotion")
    }
}

// MARK: - View Extensions

extension View {
    
    /// Fades the view based on its scroll position within a `MotionScrollView`.
    /// - Parameter fadeDistance: Distance over which the fade occurs (default: 120pt).
    func scrollFade(fadeDistance: CGFloat = 120) -> some View {
        modifier(
            ScrollFadeModifier(
                anchor: .center,
                fadeDistance: fadeDistance
            )
        )
    }
    
    /// Applies parallax motion based on scroll position.
    /// - Parameters:
    ///   - strength: Parallax multiplier (default: 0.1). Higher = more motion.
    ///   - axis: Direction of parallax (default: vertical).
    func scrollParallax(
        strength: CGFloat = 0.1,
        axis: Axis = .vertical
    ) -> some View {
        modifier(
            ScrollParallaxModifier(
                strength: strength,
                axis: axis
            )
        )
    }
    
    /// Scales the view based on proximity to the screen center.
    /// - Parameters:
    ///   - minScale: Minimum scale when far from center (default: 0.95).
    ///   - maxScale: Maximum scale at center (default: 1.0).
    func scrollScale(
        minScale: CGFloat = 0.95,
        maxScale: CGFloat = 1.0
    ) -> some View {
        modifier(
            ScrollScaleModifier(
                minScale: minScale,
                maxScale: maxScale
            )
        )
    }
}
