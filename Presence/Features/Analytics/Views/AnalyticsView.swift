//
//  AnalyticsView.swift
//  Presence
//
//  Created by Saptaswa Nandi on 09/05/26.
//

import SwiftUI

struct AnalyticsView: View {
    
    var body: some View {
        NavigationStack {
            AnalyticsDashboardView()
                .navigationTitle("Analytics")
                // Uses the modern ambient background natively within Dashboard
        }
    }
}

#Preview {
    AnalyticsView()
}