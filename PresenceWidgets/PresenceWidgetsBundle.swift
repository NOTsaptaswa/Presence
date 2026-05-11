//
//  PresenceWidgetsBundle.swift
//  PresenceWidgets
//
//  Created by Saptaswa Nandi on 09/05/26.
//

import WidgetKit
import SwiftUI

@main
struct PresenceWidgetsBundle: WidgetBundle {
    var body: some Widget {
        PresenceWidgets()
        PresenceWidgetsControl()
        PresenceWidgetsLiveActivity()
    }
}
