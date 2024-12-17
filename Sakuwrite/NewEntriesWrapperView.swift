//
//  NewEntriesWrapperView.swift
//  Mostro
//
//  Created by Paola Barbuto Ferraiuolo on 11/12/24.
//


// NewEntriesWrapperView.swift
import SwiftUI

struct NewEntriesWrapperView: View {
    @State private var entries: [String] = []

    var body: some View {
        NewEntriesView(entries: $entries)
    }
}