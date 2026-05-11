//
//  DashboardViewModel.swift
//  Presence
//
//  Created by Saptaswa Nandi on 09/05/26.
//


import Foundation
import Observation

@Observable
final class DashboardViewModel {
    
    var isLoading: Bool = true
    
    func loadDashboard() async {
        isLoading = true
        try? await Task.sleep(nanoseconds: 1_200_000_000) // 1.2s shimmer
        isLoading = false
    }
    
    var metrics: [DashboardMetric] = [
        
        DashboardMetric(
            title: "Recovery",
            value: "82%",
            systemImage: "heart.fill"
        ),
        
        DashboardMetric(
            title: "Focus",
            value: "74%",
            systemImage: "brain.head.profile"
        ),
        
        DashboardMetric(
            title: "Sleep",
            value: "7.3h",
            systemImage: "bed.double.fill"
        ),
        
        DashboardMetric(
            title: "Screen Time",
            value: "4.8h",
            systemImage: "iphone"
        )
    ]
}