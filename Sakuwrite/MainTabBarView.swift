//
//  MainTabBarView.swift
//  Mostro
//
//  Created by Paola Barbuto Ferraiuolo on 11/12/24.
//


import SwiftUI

struct MainTabBarView: View {
    @State private var selectedTab: Int = 0
    @Namespace private var slideAnimation
    @State private var showNewJournalPage = false
    @State private var savedEntries: [JournalEntry] = [] // List of saved journal entries

    var body: some View {
        VStack {
            Spacer()

            // Display content based on selected tab
            Group {
                switch selectedTab {
                case 0: CalendarView()
                case 1: ContentView()
                case 2: FavouritesView()
                case 3: SavedEntriesView(entries: $savedEntries) // Pass savedEntries as Binding
                default: Text("Unknown Tab")
                }
            }

            Spacer()

            // Custom Tab Bar
            HStack {
                HStack(spacing: 40) {
                    tabBarButton(imageName: "calendar", index: 0) {
                        withAnimation(.easeInOut(duration: 0.3)) {
                            selectedTab = 0
                        }
                    }

                    tabBarButton(imageName: "house.fill", index: 1) {
                        withAnimation(.easeInOut(duration: 0.3)) {
                            selectedTab = 1
                        }
                    }

                    tabBarButton(imageName: "heart.fill", index: 2) {
                        withAnimation(.easeInOut(duration: 0.3)) {
                            selectedTab = 2
                        }
                    }

                    tabBarButton(imageName: "list.bullet", index: 3) {
                        withAnimation(.easeInOut(duration: 0.3)) {
                            selectedTab = 3
                        }
                    }
                }
                .padding(.vertical, 15)
                .padding(.horizontal, 30)
                .background(Capsule().fill(Color.white))
                .shadow(radius: 20)

                Button {
                    withAnimation {
                        showNewJournalPage.toggle()
                    }
                } label: {
                    Image(systemName: "plus")
                        .resizable()
                        .frame(width: 25, height: 25)
                        .foregroundStyle(Color.pink)
                }
                .padding(15)
                .background(Circle().fill(Color.white))
                .shadow(radius: 20)
                
            }
            .padding(.horizontal, 15)
        }
        .sheet(isPresented: $showNewJournalPage) {
            NewJournalPage(savedEntries: $savedEntries) // Pass savedEntries to the sheet
                .clipShape(RoundedRectangle(cornerRadius: 25, style: .continuous))
                .padding(20)
            
        }
    }

    func tabBarButton(imageName: String, index: Int, action: @escaping () -> Void) -> some View {
        Button(action: action) {
            Image(systemName: imageName)
                .resizable()
                .frame(width: 25, height: 25)
                .foregroundColor(Color.pink)
        }
        .background {
            if selectedTab == index {
                Capsule()
                    .frame(width: 65, height: 40)
                    .matchedGeometryEffect(id: "background", in: slideAnimation)
            }
        }
    }
}

struct NewJournalPage: View {
    @Binding var savedEntries: [JournalEntry] // Binding to save entries
    @State private var title = ""
    @State private var journalText = ""
    @State private var isFavorite = false

    var body: some View {
        VStack {
            HStack {
                Button(action: {
                    isFavorite.toggle()
                }) {
                    Image(systemName: isFavorite ? "heart.fill" : "heart")
                        .foregroundColor(Color.pink)
                        .font(.title)
                        .padding(.leading, 15)
                }

                Spacer()

                Button("Save") {
                    let newEntry = JournalEntry(title: title, body: journalText, isFavorite: isFavorite)
                    savedEntries.append(newEntry) // Save the entry
                }
                .padding(15)
                .background(Color.pink)
                .foregroundColor(.white)
                .clipShape(Capsule())
                .padding(.trailing, 15)
            }

            TextField("Enter title", text: $title)
                .padding()
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding(.top, 20)

            TextEditor(text: $journalText)
                .padding()
                .cornerRadius(10) // Removed border styling

            Spacer()
        }
        .background(Color.white)
        .edgesIgnoringSafeArea(.top)
    }
}

struct SavedEntriesView: View {
    @Binding var entries: [JournalEntry]

    var body: some View {
        VStack {
            if entries.isEmpty {
                Text("No Saved Entries")
                    .foregroundColor(.gray)
                    .font(.title)
            } else {
                List {
                    ForEach(entries) { entry in
                        VStack(alignment: .leading) {
                            Text(entry.title)
                                .font(.headline)
                            Text(entry.body)
                                .font(.subheadline)
                                .foregroundColor(.gray)
                        }
                        .padding(.vertical, 5)
                    }
                    .onDelete(perform: deleteEntry) // Swipe to delete
                }
            }
        }
    }

    // Delete entry function
    private func deleteEntry(at offsets: IndexSet) {
        entries.remove(atOffsets: offsets)
    }
}

struct JournalEntry: Identifiable {
    let id = UUID()
    let title: String
    let body: String
    let isFavorite: Bool
}

#Preview {
    MainTabBarView()
}
