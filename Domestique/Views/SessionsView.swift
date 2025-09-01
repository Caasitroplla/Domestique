//
//  SessionsView.swift
//  Domestique
//
//  Created by Issac Allport on 01/09/2025.
//

import SwiftUI

struct SessionsView: View {
    @Binding var sessions: [Session]
    let saveAction: () -> Void
    
    @Environment(\.scenePhase) private var scenePhase
    
    @State private var showingConfirmAlert = false
    
    var body: some View {
        List {
            Section("Sessions") {
                ForEach(sessions) { session in
                    NavigationLink(
                        destination: { DetailView(session: binding(for: session) ) },
                        label: { CardView(session: session) })
                    .listRowBackground(session.color)
                }
            }
            
            Section("Weekly Stats") {
                StatsView(sessions: $sessions)
            }
        }
            .onChange(of: scenePhase, {saveAction()})
            .navigationTitle("Domestqiue")
            .toolbar {
                ToolbarItem(placement: .primaryAction) {
                    Button(action: {
                        // Reseting the list of sessions
                        showingConfirmAlert = true
                    }) {
                        Label("Reset", systemImage: "arrow.2.circlepath.circle")
                    }
                }
            }
            .alert("Confirm Alert", isPresented: $showingConfirmAlert) {
                Button("Confirm", role: .confirm) {
                    sessions = Session.data
                }
                Button("Cancel", role: .cancel) {
                    
                }
            } message: {
                Text("Are you sure you want to reset the training options?")
            }
    }
    
    private func binding(for session: Session) -> Binding<Session> {
        guard let sessionIndex = sessions.firstIndex(where: { $0.id == session.id }) else {
            fatalError("Can't find the session in the array")
        }
        return $sessions[sessionIndex]
    }
}

#Preview {
    NavigationView{
        SessionsView(sessions: .constant(Session.data), saveAction: {})
    }
}
