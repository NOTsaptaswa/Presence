//
//  FloatingTabBar.swift
//  Presence
//
//  Created by Saptaswa Nandi on 09/05/26.
//


import SwiftUI

struct FloatingTabBar: View {
    
    @Binding var selectedTab: TabItem
    
    var body: some View {
        
        HStack {
            
            ForEach(TabItem.allCases, id: \.self) { tab in
                
                Button {
                    
                    withAnimation(MotionTokens.snappySpring) {
                        selectedTab = tab
                        HapticsManager.shared.selection()
                    }
                    
                } label: {
                    
                    VStack(spacing: 6) {
                        
                        Image(systemName: tab.icon)
                            .font(.system(size: 18, weight: .semibold))
                        
                        Text(tab.title)
                            .font(.caption2)
                    }
                    .foregroundStyle(
                        selectedTab == tab
                        ? Color.white
                        : AppColors.secondaryText
                    )
                    .frame(maxWidth: .infinity)
                    .padding(.vertical, 12)
                }
            }
        }
        .padding(10)
        .background(.ultraThinMaterial)
        .clipShape(
            RoundedRectangle(cornerRadius: 30)
        )
        .padding(.horizontal, 20)
        .shadow(radius: 20)
    }
}

#Preview {
    FloatingTabBar(
        selectedTab: .constant(.dashboard)
    )
}
