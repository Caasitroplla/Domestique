//
//  SessionData.swift
//  Domestique
//
//  Created by Issac Allport on 01/09/2025.
//

import Foundation
internal import Combine

class SessionData: ObservableObject {
    
    private static var documentsFolder: URL {
        do {
            return try FileManager.default.url(for: .documentDirectory,
                                               in: .userDomainMask,
                                               appropriateFor: nil,
                                               create: false)
        } catch {
            fatalError("Can't find documents directory.")
        }
    }
    
    private static var fileURL: URL {
        return documentsFolder.appendingPathComponent("sessions.data")
    }
    
    @Published var sessions: [Session] = []

    func load() {
        DispatchQueue.global(qos: .background).async { [weak self] in
            guard let data = try? Data(contentsOf: Self.fileURL) else {
                #if DEBUG
                DispatchQueue.main.async {
                    self?.sessions = Session.data
                }
                #endif
                return
            }
            guard let sessions = try? JSONDecoder().decode([Session].self, from: data) else {
                fatalError("Can't decode saved scrum data.")
            }
            DispatchQueue.main.async {
                self?.sessions = sessions
            }
        }
    }
    
    func save() {
        DispatchQueue.global(qos: .background).async { [weak self] in
            guard let sessions = self?.sessions else { fatalError("Self out of scope") }
            guard let data = try? JSONEncoder().encode(sessions) else { fatalError("Error encoding data") }
            do {
                let outfile = Self.fileURL
                try data.write(to: outfile)
            } catch {
                fatalError("Can't write to file")
            }
        }
    }
    
}
