//
//  SkeletonSystem.swift
//  Presence
//
//  A premium, lightweight skeleton loading system for Presence.
//  Provides subtle shimmer effects and reusable loading components.
//

import SwiftUI

// MARK: - Shimmer Modifier

struct ShimmerModifier: ViewModifier {
    @State private var phase: CGFloat = -1.0
    
    func body(content: Content) -> some View {
        content
            .overlay(
                GeometryReader { geometry in
                    let width = geometry.size.width
                    
                    LinearGradient(
                        stops: [
                            .init(color: .clear, location: 0),
                            .init(color: .white.opacity(0.08), location: 0.5),
                            .init(color: .clear, location: 1)
                        ],
                        startPoint: .leading,
                        endPoint: .trailing
                    )
                    .frame(width: width * 1.5)
                    .offset(x: phase * width)
                    .mask(content)
                }
            )
            .onAppear {
                withAnimation(
                    .linear(duration: 2.0)
                    .repeatForever(autoreverses: false)
                ) {
                    phase = 1.0
                }
            }
    }
}

extension View {
    /// Adds a subtle shimmering light effect to the view.
    func shimmer() -> some View {
        modifier(ShimmerModifier())
    }
}

// MARK: - Skeleton Primitives

public struct SkeletonShape: View {
    let width: CGFloat?
    let height: CGFloat
    let cornerRadius: CGFloat
    
    public init(width: CGFloat? = nil, height: CGFloat, cornerRadius: CGFloat = 8) {
        self.width = width
        self.height = height
        self.cornerRadius = cornerRadius
    }
    
    public var body: some View {
        RoundedRectangle(cornerRadius: cornerRadius, style: .continuous)
            .fill(Color.white.opacity(0.05))
            .frame(width: width, height: height)
            .shimmer()
    }
}

// MARK: - Skeleton Cards

public struct SkeletonMetricCard: View {
    public var body: some View {
        VStack(alignment: .leading, spacing: 18) {
            SkeletonShape(width: 24, height: 24, cornerRadius: 6) // Icon
            
            Spacer()
            
            VStack(alignment: .leading, spacing: 8) {
                SkeletonShape(width: 60, height: 28) // Value
                SkeletonShape(width: 80, height: 16) // Title
            }
        }
        .padding(22)
        .frame(height: 170)
        .frame(maxWidth: .infinity, alignment: .leading)
        .background(.ultraThinMaterial)
        .clipShape(RoundedRectangle(cornerRadius: AppRadius.card, style: .continuous))
    }
}

public struct SkeletonHeroCard: View {
    public var body: some View {
        VStack(alignment: .leading, spacing: 20) {
            HStack {
                VStack(alignment: .leading, spacing: 8) {
                    SkeletonShape(width: 80, height: 16) // Subtitle
                    SkeletonShape(width: 120, height: 44) // Score
                }
                Spacer()
                SkeletonShape(width: 32, height: 32, cornerRadius: 8) // Icon
            }
            
            VStack(alignment: .leading, spacing: 10) {
                SkeletonShape(width: 200, height: 18) // Heading
                SkeletonShape(width: 160, height: 14) // Subheading
            }
        }
        .padding(28)
        .frame(height: 240)
        .frame(maxWidth: .infinity, alignment: .leading)
        .background(.ultraThinMaterial)
        .clipShape(RoundedRectangle(cornerRadius: AppRadius.card, style: .continuous))
    }
}

public struct SkeletonChartCard: View {
    public var body: some View {
        VStack(alignment: .leading, spacing: 20) {
            HStack {
                VStack(alignment: .leading, spacing: 6) {
                    SkeletonShape(width: 140, height: 18)
                    SkeletonShape(width: 80, height: 12)
                }
                Spacer()
                SkeletonShape(width: 20, height: 20)
            }
            
            // Mock Chart Area
            HStack(alignment: .bottom, spacing: 12) {
                ForEach(0..<7, id: \.self) { i in
                    SkeletonShape(height: CGFloat.random(in: 40...100))
                        .opacity(1.0 - (Double(i) * 0.1))
                }
            }
            .frame(height: 120)
        }
        .padding(24)
        .background(.ultraThinMaterial)
        .clipShape(RoundedRectangle(cornerRadius: AppRadius.card, style: .continuous))
    }
}

// MARK: - Layout Views

public struct DashboardLoadingView: View {
    let columns = [GridItem(.flexible()), GridItem(.flexible())]
    
    public var body: some View {
        VStack(spacing: AppSpacing.sectionSpacing) {
            SkeletonHeroCard()
            
            LazyVGrid(columns: columns, spacing: 16) {
                ForEach(0..<4, id: \.self) { _ in
                    SkeletonMetricCard()
                }
            }
        }
    }
}

public struct AnalyticsLoadingView: View {
    public var body: some View {
        VStack(spacing: 24) {
            HStack(spacing: 16) {
                SkeletonMetricCard()
                SkeletonMetricCard()
            }
            
            SkeletonChartCard()
            SkeletonChartCard()
        }
    }
}

// MARK: - Previews

#Preview("Dashboard Loading") {
    ZStack {
        AmbientBackgroundView()
        ScrollView {
            DashboardLoadingView()
                .padding()
        }
    }
    .preferredColorScheme(.dark)
}

#Preview("Analytics Loading") {
    ZStack {
        AmbientBackgroundView()
        ScrollView {
            AnalyticsLoadingView()
                .padding()
        }
    }
    .preferredColorScheme(.dark)
}
