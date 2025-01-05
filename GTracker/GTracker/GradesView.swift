//
//  GradesView.swift
//  Grade Tracker (actually final)
//
//  Created by Swetha Panyam on 12/30/24.
//
import SwiftUI
import SwiftData

struct GradesView: View {
    // Use @Query to fetch courses sorted by name
    @Query(sort: \Course.name, order: .forward) private var courses: [Course]

    var body: some View {
        List(courses) { course in
            VStack(alignment: .leading) {
                Text(course.name ?? "Unknown Course")
                Text("Year: \(course.year)") // No need for manual conversion
                Text("Final Grade: \(calculateFinalGrade(for: course))") // Show calculated grade
            }
        }
        .navigationTitle("Grades")
    }

    // Function to calculate the final grade
    private func calculateFinalGrade(for course: Course) -> Int {
        let semester1 = Int(course.semester1Grade) // Convert from Int16
        let semester2 = Int(course.semester2Grade) // Convert from Int16
        return (semester1 + semester2) / 2
    }
}
