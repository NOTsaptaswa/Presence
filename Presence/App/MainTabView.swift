//
//  MainTabView.swift
//  Presence
//
//  Created by Saptaswa Nandi on 09/05/26.
//

import SwiftUI

struct MainTabView: View {
    
    @State private var selectedTab: TabItem = .dashboard
    
    var body: some View {
        
        ZStack(alignment: .bottom) {
            
            Group {
                
                switch selectedTab {
                    
                case .dashboard:
                    DashboardView()
                    
                case .analytics:
                    AnalyticsView()
                    
                case .reflection:
                    ReflectionView()
                    
                case .settings:
                    SettingsView()
                }
            }
            
            FloatingTabBar(
                selectedTab: $selectedTab
            )
            .padding(.bottom, 12)
        }
    }
}

#Preview {
    MainTabView()
}
