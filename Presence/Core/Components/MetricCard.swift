//
//  MetricCard.swift
//  Presence
//
//  Created by Saptaswa Nandi on 09/05/26.
//


import SwiftUI

struct MetricCard: View {
    
    let title: String
    
    let value: String
    
    let systemImage: String
    
    var body: some View {
        
        VStack(alignment: .leading, spacing: 18) {
            
            Image(systemName: systemImage)
                .font(.title3)
            
            Spacer()
            
            VStack(alignment: .leading, spacing: 6) {
                
                Text(value)
                    .font(Typography.cardValue)
                
                Text(title)
                    .font(Typography.subheadline)
                    .foregroundStyle(AppColors.secondaryText)
            }
        }
        .padding(22)
        .frame(height: 170)
        .frame(maxWidth: .infinity)
        .background(.ultraThinMaterial)
        .clipShape(
            RoundedRectangle(
                cornerRadius: AppRadius.card
            )
        )
        .contentShape(RoundedRectangle(cornerRadius: AppRadius.card))
        .accessibilityElement(children: .combine)
        .accessibilityLabel(title)
        .accessibilityValue(value)
        .accessibilityAddTraits(.isButton)
    }
}
