//
//  DashboardMetric.swift
//  Presence
//
//  Created by Saptaswa Nandi on 09/05/26.
//


import Foundation

struct DashboardMetric: Identifiable {
    
    let id = UUID()
    
    let title: String
    
    let value: String
    
    let systemImage: String
}