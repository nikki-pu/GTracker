import SwiftUI

struct ContentView: View {
    var body: some View {
        NavigationView {
            VStack(spacing: 20) {
                Text("Welcome Back, [Name]")
                    .font(.title)

                NavigationLink(destination: GPAView()) {
                    NavBlockView(title: "GPA", icon: "chart.bar.fill")
                }

                NavigationLink(destination: TranscriptView()) {
                    NavBlockView(title: "Transcript", icon: "doc.text.magnifyingglass")
                }

                NavigationLink(destination: GradesView()) {
                    NavBlockView(title: "Grades", icon: "list.bullet.rectangle")
                }

                NavigationLink(destination: ScheduleView()) {
                    NavBlockView(title: "Schedule", icon: "calendar")
                }

                Spacer()
            }
            .padding()
            .navigationTitle("AcedIT")
            .toolbar {
                ToolbarItem(placement: .automatic) { // Cross-platform toolbar placement
                    Button(action: logOut) {
                        Image(systemName: "person.crop.circle")
                    }
                }
            }
        }
    }

    private func logOut() {
        // Reset login status or handle logout logic
        UserDefaults.standard.set(false, forKey: "isAuthenticated")
    }
}

struct NavBlockView: View {
    let title: String
    let icon: String

    var body: some View {
        HStack {
            Image(systemName: icon)
                .font(.largeTitle)
                .foregroundColor(.blue)
            Text(title)
                .font(.headline)
                .padding(.leading, 10)
            Spacer()
        }
        .padding()
        .background(backgroundColor) // Use the computed property here
        .cornerRadius(10)
    }

    // Computed property for platform-specific background color
    private var backgroundColor: Color {
        #if os(macOS)
        return Color(NSColor.controlBackgroundColor) // macOS color
        #else
        return Color(UIColor.systemGray6) // iOS color
        #endif
    }
}

