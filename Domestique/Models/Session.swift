//
//  Session.swift
//  Domestique
//
//  Created by Issac Allport on 01/09/2025.
//

import SwiftUI

struct Session: Codable, Identifiable {
    let id: UUID
    var title: String
    var duration: Int
    var sections: [String]
    var type: String
    var color: Color
    var day: Int
    
    init(id: UUID = UUID(), title: String, duration: Int, sections: [String], type: String, color: Color, day: Int) {
        self.id = id
        self.title = title
        self.duration = duration
        self.sections = sections
        self.type = type
        self.color = color
        self.day = day
    }
}

extension Session {
    static var data: [Session] {
        [
            Session(title: "Recovery Ride", duration: 60, sections: ["Easy spin"], type: "Recovery", color: .random, day: 0),
            Session(title: "Recovery Ride", duration: 60, sections: ["Easy spin"], type: "Recovery", color: .random, day: 1),
            Session(title: "Recovery Ride", duration: 60, sections: ["Easy spin"], type: "Recovery", color: .random, day: 2),
            Session(title: "Recovery Ride", duration: 60, sections: ["Easy spin"], type: "Recovery", color: .random, day: 3),
            Session(title: "Recovery Ride", duration: 60, sections: ["Easy spin"], type: "Recovery", color: .random, day: 4),
            Session(title: "Recovery Ride", duration: 60, sections: ["Easy spin"], type: "Recovery", color: .random, day: 5),
            Session(title: "Recovery Ride", duration: 60, sections: ["Easy spin"], type: "Recovery", color: .random, day: 6)
        ]
    }
}

extension Session {
    struct Data {
        var title: String = ""
        var duration: Double = 60.0
        var sections: [String] = []
        var type: String = "Recovery"
        var color: Color = .random
        var day: Int = 1
    }
    
    var data: Data {
        return Data(title: title, duration: Double(duration), sections: sections, type: type, color: color, day: day)
    }
    
    mutating func update(with data: Data) {
        self.title = data.title
        self.duration = Int(data.duration)
        self.sections = data.sections
        self.type = data.type
        self.color = data.color
        self.day = data.day
    }
}
