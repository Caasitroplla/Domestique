//
//  StatsView.swift
//  Domestique
//
//  Created by Issac Allport on 01/09/2025.
//

import SwiftUI

struct StatsView: View {
    @Binding var sessions: [Session]
    
    var totalTime: Int {
        sessions.reduce(0) { $0 + $1.duration }
    }
    
    var activeDays: Int {
        sessions.filter { $0.type != "rest" }.count
    }
    
    var body: some View {
        HStack {
            Label("Total Time", systemImage: "clock")
            Spacer()
            Text("\(totalTime / 60)h \(totalTime % 60)m")
        }
        
        HStack {
            Label("Active Days", systemImage: "calendar")
            Spacer()
            Text("\(activeDays) / 7")
        }
    }
        
}

#Preview {
    NavigationView {
        List {
            Section("Weekly Stats") {
                StatsView(sessions: .constant(Session.data))
            }
        }
    }
}

