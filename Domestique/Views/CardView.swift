//
//  CardView.swift
//  Domestique
//
//  Created by Issac Allport on 01/09/2025.
//

import SwiftUI

struct CardView: View {
    let session: Session
    var day: String {
        let days: [String] = ["Monday", "Tuesday", "Wednesday", "Thursday", "Friday", "Saturday", "Sunday"]
        return days[session.day]
        
    }
    
    var hourMinute: String {
        let hours = session.duration / 60
        let minutes = session.duration % 60
        if hours > 0 {
            return "\(hours)h \(minutes)m"
        } else {
            return "\(minutes)m"
        }
    }
    
    var body: some View {
        VStack(alignment: .leading) {
            Text(session.title)
                .font(.headline)
            HStack {
                Text(day)
                Spacer()
                Label(hourMinute, systemImage: "clock")
            }
            .font(.caption)
        }
        .padding()
        .foregroundColor(session.color.accessibleFontColor)
    }
}

#Preview(traits: .fixedLayout(width: 400, height: 60)) {
    var data = Session.data[0]
    CardView(session: data)
        .background(data.color)
}
