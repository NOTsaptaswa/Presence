import SwiftUI


public struct AmbientBackgroundView: View {
    @Environment(\.colorScheme) var colorScheme
    @State private var isAnimating = false
    
    var topOrbColor: Color
    var bottomOrbColor: Color
    var accentOrbColor: Color
    
    public init(
        topOrbColor: Color = Color.indigo,
        bottomOrbColor: Color = Color.teal,
        accentOrbColor: Color = Color.purple
    ) {
        self.topOrbColor = topOrbColor
        self.bottomOrbColor = bottomOrbColor
        self.accentOrbColor = accentOrbColor
    }
    
    private var baseOpacity: Double {
        colorScheme == .dark ? 0.2 : 0.12
    }
    
    public var body: some View {
        ZStack {
            
            Color(uiColor: .systemBackground)
                .ignoresSafeArea()
            
            GeometryReader { proxy in
                let width = proxy.size.width
                let height = proxy.size.height
                
                ZStack {
                    
                    Circle()
                        .fill(topOrbColor.opacity(baseOpacity))
                        .frame(width: width * 0.9, height: width * 0.9)
                        .position(
                            x: isAnimating ? width * 0.7 : width * 0.3,
                            y: isAnimating ? height * 0.2 : height * 0.1
                        )
                        .blur(radius: 70)
                    
                   
                    Circle()
                        .fill(bottomOrbColor.opacity(baseOpacity))
                        .frame(width: width * 1.0, height: width * 1.0)
                        .position(
                            x: isAnimating ? width * 0.2 : width * 0.8,
                            y: isAnimating ? height * 0.8 : height * 0.9
                        )
                        .blur(radius: 80)
                    
                    
                    Ellipse()
                        .fill(accentOrbColor.opacity(baseOpacity * 0.8))
                        .frame(width: width * 0.8, height: height * 0.6)
                        .position(
                            x: isAnimating ? width * 0.4 : width * 0.6,
                            y: isAnimating ? height * 0.6 : height * 0.4
                        )
                        .rotationEffect(.degrees(isAnimating ? 15 : -15))
                        .blur(radius: 90)
                }
                
                .opacity(0.8)
            }
            .ignoresSafeArea()
            .onAppear {
                
                withAnimation(
                    .easeInOut(duration: 18.0)
                    .repeatForever(autoreverses: true)
                ) {
                    isAnimating = true
                }
            }
        }
    }
}



#Preview("Dark Mode") {
    ZStack {
        AmbientBackgroundView()
        
        VStack(spacing: 12) {
            Image(systemName: "moon.stars.fill")
                .font(.system(size: 44))
                .foregroundStyle(.primary)
                
            Text("Presence")
                .font(.system(size: 34, weight: .semibold, design: .rounded))
                .foregroundStyle(.primary)
            
            Text("Focus and clarity")
                .font(.body)
                .foregroundStyle(.secondary)
        }
    }
    .preferredColorScheme(.dark)
}

#Preview("Light Mode") {
    ZStack {
        AmbientBackgroundView(
            topOrbColor: Color.indigo.opacity(0.15),
            bottomOrbColor: Color.teal.opacity(0.15),
            accentOrbColor: Color.purple.opacity(0.1)
        )
        
        VStack(spacing: 12) {
            Image(systemName: "sun.max.fill")
                .font(.system(size: 44))
                .foregroundStyle(.primary)
                
            Text("Morning Routine")
                .font(.system(size: 34, weight: .semibold, design: .rounded))
                .foregroundStyle(.primary)
            
            Text("Start your day right")
                .font(.body)
                .foregroundStyle(.secondary)
        }
    }
    .preferredColorScheme(.light)
}
