//
//  RecoveryHeroCard.swift
//  Presence
//
//  Created by Saptaswa Nandi on 09/05/26.
//


import SwiftUI

struct RecoveryHeroCard: View {
    
    var body: some View {
        
        ZStack {
            
            RoundedRectangle(cornerRadius: 32)
                .fill(.ultraThinMaterial)
            
            VStack(alignment: .leading, spacing: 20) {
                
                HStack {
                    
                    VStack(alignment: .leading, spacing: 6) {
                        
                        Text("Recovery")
                            .foregroundStyle(.secondary)
                        
                        Text("82%")
                            .font(.system(size: 54, weight: .bold))
                    }
                    
                    Spacer()
                    
                    Image(systemName: "heart.fill")
                        .font(.system(size: 32))
                }
                
                VStack(alignment: .leading, spacing: 8) {
                    
                    Text("You’re well recovered today.")
                        .font(.headline)
                    
                    Text("Sleep and activity trends indicate balanced recovery.")
                        .foregroundStyle(.secondary)
                }
            }
            .padding(28)
        }
        .frame(height: 240)
    }
}

#Preview {
    RecoveryHeroCard()
        .padding()
}