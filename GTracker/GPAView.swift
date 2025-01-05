import SwiftUI
import SwiftData

struct GPAView: View {
    // Fetch courses using SwiftData's @Query
    @Query(sort: \Course.name, order: .forward) private var courses: [Course]

    var body: some View {
        VStack(spacing: 20) {
            // Display Weighted GPA
            Text("Weighted GPA (6.0 Scale): \(String(format: "%.2f", calculateGPA(weighted: true)))")
                .font(.title)

            // Display Unweighted GPA
            Text("Unweighted GPA (4.0 Scale): \(String(format: "%.2f", calculateGPA(weighted: false)))")
                .font(.title)

            // List courses
            List(courses) { course in
                VStack(alignment: .leading) {
                    Text(course.name ?? "Unknown Course")
                        .font(.headline)
                    Text("Credits: \(course.credits)")
                    Text("Grade: \(course.grade ?? "N/A")")
                    Text("Year: \(course.year)")
                }
                .padding(.vertical, 8)
            }
        }
        .navigationTitle("GPA")
        .padding()
    }

    // Calculate GPA
    private func calculateGPA(weighted: Bool) -> Double {
        let totalCredits = courses.reduce(0) { $0 + $1.credits }
        let totalPoints = courses.reduce(0) { total, course in
            let gradePoint = weighted ? weightedGPA(course: course) : unweightedGPA(course: course)
            return total + (gradePoint * course.credits)
        }

        guard totalCredits > 0 else { return 0.0 }
        return totalPoints / totalCredits
    }

    // Calculate Weighted GPA
    private func weightedGPA(course: Course) -> Double {
        let baseGPA = unweightedGPA(course: course)
        switch course.tier {
        case 1: return baseGPA + 2.0
        case 2: return baseGPA + 1.0
        default: return baseGPA
        }
    }

    // Calculate Unweighted GPA
    private func unweightedGPA(course: Course) -> Double {
        switch course.grade?.uppercased() {
        case "A": return 4.0
        case "B": return 3.0
        case "C": return 2.0
        case "D": return 1.0
        case "F": return 0.0
        default: return 0.0
        }
    }
}
