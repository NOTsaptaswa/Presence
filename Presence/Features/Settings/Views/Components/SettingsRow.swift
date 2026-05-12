//
//  SettingsRow.swift
//  Presence
//
//  Premium reusable row component for the Presence Settings system.
//

import SwiftUI

public struct SettingsRow: View {
    let icon: String
    let iconColor: Color
    let title: String
    var subtitle: String? = nil
    var showChevron: Bool = true
    let action: () -> Void
    
    public init(
        icon: String,
        iconColor: Color,
        title: String,
        subtitle: String? = nil,
        showChevron: Bool = true,
        action: @escaping () -> Void
    ) {
        self.icon = icon
        self.iconColor = iconColor
        self.title = title
        self.subtitle = subtitle
        self.showChevron = showChevron
        self.action = action
    }
    
    public var body: some View {
        Button(action: action) {
            HStack(spacing: 16) {
                // MARK: - Icon
                ZStack {
                    RoundedRectangle(cornerRadius: 10, style: .continuous)
                        .fill(iconColor.opacity(0.1))
                        .frame(width: 34, height: 34)
                    
                    Image(systemName: icon)
                        .font(.system(size: 16, weight: .semibold))
                        .foregroundStyle(iconColor)
                }
                
                // MARK: - Labels
                VStack(alignment: .leading, spacing: 2) {
                    Text(title)
                        .font(.system(size: 17, weight: .medium))
                        .foregroundStyle(.primary)
                    
                    if let subtitle = subtitle {
                        Text(subtitle)
                            .font(.system(size: 13))
                            .foregroundStyle(.secondary)
                    }
                }
                
                Spacer()
                
                // MARK: - Trailing
                if showChevron {
                    Image(systemName: "chevron.right")
                        .font(.system(size: 14, weight: .bold))
                        .foregroundStyle(.tertiary)
                }
            }
            .padding(.vertical, 8)
        }
        .buttonStyle(.plain)
    }
}

public struct SettingsToggleRow: View {
    let icon: String
    let iconColor: Color
    let title: String
    @Binding var isOn: Bool
    
    public var body: some View {
        HStack(spacing: 16) {
            ZStack {
                RoundedRectangle(cornerRadius: 10, style: .continuous)
                    .fill(iconColor.opacity(0.1))
                    .frame(width: 34, height: 34)
                
                Image(systemName: icon)
                    .font(.system(size: 16, weight: .semibold))
                    .foregroundStyle(iconColor)
            }
            
            Text(title)
                .font(.system(size: 17, weight: .medium))
                .foregroundStyle(.primary)
            
            Spacer()
            
            Toggle("", isOn: $isOn)
                .labelsHidden()
                .tint(iconColor)
        }
        .padding(.vertical, 8)
    }
}
