//
//  EditView.swift
//  Domestique
//
//  Created by Issac Allport on 01/09/2025.
//

import SwiftUI

struct EditView: View {
    @Binding var sessionData: Session.Data
    @State private var newStep: String = ""
    
    private let options: [String] = ["Rest", "Recovery", "Endurance", "Intervals", "Race", "Cafe"]
    
    var body: some View {
        List {
            Section("Session Info") {
                TextField("Title", text: $sessionData.title)
                
                HStack {
                    Slider(value: $sessionData.duration, in: 0...360, step: 15.0) {
                        Text("Length")
                    }
                    Spacer()
                    Text("\(Int(sessionData.duration)) minutes")
                }
                
                ColorPicker("Color", selection: $sessionData.color)
                
                Picker("Type", selection: $sessionData.type) {
                    ForEach(options, id: \.self) { option in
                        Text(option)
                    }
                }
                .pickerStyle(.menu)
            }
            
            Section("Steps") {
                ForEach(sessionData.sections, id: \.self) { section in
                    Text(section)
                }
                .onDelete {indices in
                    sessionData.sections.remove(atOffsets: indices)
                }
                HStack {
                    TextField("New Step", text: $newStep)
                    Button(action: {
                        withAnimation {
                            sessionData.sections.append(newStep)
                            newStep = ""
                        }
                    }) {
                        Image(systemName: "plus.circle.fill")
                    }
                    .disabled(newStep.isEmpty)
                }
            }
        }
    }
}

#Preview {
    NavigationView {
        EditView(sessionData: .constant(Session.data[0].data))
    }
}
