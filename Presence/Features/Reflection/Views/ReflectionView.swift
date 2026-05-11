//
//  ReflectionView.swift
//  Presence
//
//  Created by Saptaswa Nandi on 09/05/26.
//

import SwiftUI

struct ReflectionView: View {
    
    var body: some View {
        NavigationStack {
            ReflectionDashboardView()
                .navigationTitle("Reflection")
        }
    }
}

#Preview {
    ReflectionView()
}