//
//  DetailView.swift
//  Domestique
//
//  Created by Issac Allport on 01/09/2025.
//

import SwiftUI

struct DetailView: View {
    @Binding var session: Session
    @State private var sessionData: Session.Data = Session.Data()
    @State private var isPresented: Bool = false
    
    var day: String {
        let days: [String] = ["Monday", "Tuesday", "Wednesday", "Thursday", "Friday", "Saturday", "Sunday"]
        return days[session.day]
        
    }
    
    var body: some View {
        List {
            Section("Session Info") {
                HStack {
                    Label("Length", systemImage: "clock")
                        .accessibilityLabel(Text("Session length"))
                    Spacer()
                    Text("\(session.duration) minutes")
                }
                HStack {
                    Label("Color", systemImage: "paintpalette")
                    Spacer()
                    Image(systemName: "checkmark.circle.fill")
                        .foregroundColor(session.color)
                }
                HStack {
                    Label("Day", systemImage: "calendar")
                    Spacer()
                    Text(day)
                }
                HStack {
                    Label("Type", systemImage: "gauge.with.needle")
                    Spacer()
                    Text(session.type)
                }
            }
            
            Section("Steps") {
                ForEach(session.sections, id: \.self) { step in
                    Text(step)
                }
            }
        }
        .toolbar {
            ToolbarItem(placement: .primaryAction) {
                Button("Edit") {
                    sessionData = session.data
                    isPresented = true
                }
            }
        }
        .navigationTitle(session.title)
        .fullScreenCover(isPresented: $isPresented) {
            NavigationView {
                EditView(sessionData: $sessionData)
                    .navigationTitle(day)
                    .toolbar {
                        ToolbarItem(placement: .primaryAction) {
                            Button("Cancel") {
                                isPresented = false
                            }
                        }
                        ToolbarItem(placement: .confirmationAction) {
                            Button("Done") {
                                isPresented = false
                                session.update(with: sessionData)
                            }
                        }
                    }
                
            }
        }
    }
}

#Preview {
    NavigationView {
        DetailView(session: .constant(Session.data[0]))
    }
}
