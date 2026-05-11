//
//  TabItem.swift
//  Presence
//
//  Created by Saptaswa Nandi on 09/05/26.
//


import Foundation

enum TabItem: CaseIterable {
    
    case dashboard
    
    case analytics
    
    case reflection
    
    case settings
    
    var title: String {
        
        switch self {
            
        case .dashboard:
            return "Dashboard"
            
        case .analytics:
            return "Analytics"
            
        case .reflection:
            return "Reflection"
            
        case .settings:
            return "Settings"
        }
    }
    
    var icon: String {
        
        switch self {
            
        case .dashboard:
            return "square.grid.2x2.fill"
            
        case .analytics:
            return "chart.xyaxis.line"
            
        case .reflection:
            return "moon.stars.fill"
            
        case .settings:
            return "gearshape.fill"
        }
    }
}