//
//  CalendarView.swift
//  Mostro
//
//  Created by Paola Barbuto Ferraiuolo on 11/12/24.
//


import SwiftUI

struct CalendarView: View {
    // Get the current date
    @State private var currentDate = Date()

    // Selected day
    @State private var selectedDay: String? = nil

    // Helper for days of the week
    private let daysOfWeek = ["Sun", "Mon", "Tue", "Wed", "Thu", "Fri", "Sat"]

    var body: some View {
        VStack {
            // Title in a consistent header area
            HStack {
                Text("Calendar")
                    .font(.largeTitle)
                    .fontWeight(.bold)
        
            }
            Spacer()
    
             // Consistent height for header

            // Month and Year Header
            Text(currentDate, formatter: monthYearFormatter)
                .font(.title)
                .padding()

            // Days of the week header
            HStack {
                ForEach(daysOfWeek, id: \.self) { day in
                    Text(day)
                        .fontWeight(.bold)
                        .frame(maxWidth: .infinity)
                }
            }
    

            // Calendar grid
            let days = generateCalendarDays(for: currentDate)
            LazyVGrid(columns: Array(repeating: GridItem(.flexible()), count: 7), spacing: 10) {
                ForEach(days, id: \.self) { day in
                    Text(day)
                        .frame(maxWidth: .infinity, minHeight: 40)
                        .background(
                            day == selectedDay ? Color.pink.opacity(0.5) : Color.pink.opacity(day.isEmpty ? 0 : 0.2)
                        )
                        .cornerRadius(5)
                        .onTapGesture {
                            if !day.isEmpty {
                                selectedDay = day
                            }
                        }
                }
            }
            Spacer()

            // Navigation Buttons
            HStack {
                Button(action: previousMonth) {
                    Label("Previous", systemImage: "chevron.left")
                        .foregroundColor(.pink)
                }
                Spacer()
                Button(action: nextMonth) {
                    Label("Next", systemImage: "chevron.right")
                        .foregroundColor(.pink)
                        .padding(.vertical)
                }
            }
            .padding()
        }
        .padding()
    }

    private var monthYearFormatter: DateFormatter {
        let formatter = DateFormatter()
        formatter.dateFormat = "MMMM yyyy"
        return formatter
    }

    private func generateCalendarDays(for date: Date) -> [String] {
        var days = [String]()
        let calendar = Calendar.current

        // Get the first day of the month
        guard let startOfMonth = calendar.date(from: calendar.dateComponents([.year, .month], from: date)) else {
            return days
        }

        // Determine the weekday offset for the first day
        let weekdayOffset = calendar.component(.weekday, from: startOfMonth) - 1

        // Add empty days for the offset
        days.append(contentsOf: Array(repeating: "", count: weekdayOffset))

        // Add all days in the current month
        if let range = calendar.range(of: .day, in: .month, for: startOfMonth) {
            days.append(contentsOf: range.map { String($0) })
        }

        return days
    }

    private func previousMonth() {
        if let newDate = Calendar.current.date(byAdding: .month, value: -1, to: currentDate) {
            currentDate = newDate
        }
    }

    private func nextMonth() {
        if let newDate = Calendar.current.date(byAdding: .month, value: 1, to: currentDate) {
            currentDate = newDate
        }
    }
}
    

struct CalendarView_Previews: PreviewProvider {
    static var previews: some View {
        CalendarView()
    }
}
