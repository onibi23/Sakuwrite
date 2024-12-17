//
//  NewEntriesView.swift
//  Mostro
//
//  Created by Paola Barbuto Ferraiuolo on 11/12/24.
//


// NewEntriesView.swift
import SwiftUI

struct NewEntriesView: View {
    @Binding var entries: [String]

    var body: some View {
        VStack {
            List(entries, id: \ .self) { entry in
                Text(entry)
            }

            Button(action: addNewEntry) {
                Text("Add")
                    .padding()
                    .background(Color.accentColor)
                    .foregroundColor(.white)
                    .cornerRadius(10)
            }
            .padding()
        }
    }

    func addNewEntry() {
        let newEntry = "Entry \(entries.count + 1)"
        entries.append(newEntry)
    }
}