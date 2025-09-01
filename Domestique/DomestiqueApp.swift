//
//  DomestiqueApp.swift
//  Domestique
//
//  Created by Issac Allport on 01/09/2025.
//

import SwiftUI

@main
struct DomestiqueApp: App {
    @ObservedObject private var data = SessionData()
    var body: some Scene {
        WindowGroup {
            NavigationView {
                SessionsView(sessions: $data.sessions, saveAction: {
                    data.save()
                })
            }
            .onAppear {
                data.load()
            }
        }
    }
}
