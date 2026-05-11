//
//  DashboardHeader.swift
//  Presence
//
//  Created by Saptaswa Nandi on 09/05/26.
//


import SwiftUI

struct DashboardHeader: View {
    
    var body: some View {
        
        VStack(alignment: .leading, spacing: 8) {
            
            Text("Good Afternoon")
                .font(Typography.subheadline)
                .foregroundStyle(AppColors.secondaryText)
            
            Text("Your Presence")
                .font(Typography.heroTitle)
        }
        .frame(maxWidth: .infinity, alignment: .leading)
    }
}
