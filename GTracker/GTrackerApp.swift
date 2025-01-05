import SwiftUI
import SwiftData

@main
struct GTrackerApp: App {
    @AppStorage("isAuthenticated") private var isAuthenticated: Bool = false // Persistent storage for authentication state

    var sharedModelContainer: ModelContainer = {
        // Define the schema with all @Model types
        let schema = Schema([
            User.self,
            Item.self,  // Ensure this is annotated with @Model
            Course.self // Include all other models
        ])

        // Configure the model container (in-memory or persistent)
        let modelConfiguration = ModelConfiguration(schema: schema, isStoredInMemoryOnly: false)

        do {
            // Try to create the ModelContainer
            return try ModelContainer(for: schema, configurations: [modelConfiguration])
        } catch {
            // Log the error if initialization fails
            fatalError("Could not create ModelContainer: \(error)")
        }
    }()

    var body: some Scene {
        WindowGroup {
            if isAuthenticated {
                ContentView() // Show ContentView if the user is authenticated
                    .environmentObject(UserStore(context: sharedModelContainer.mainContext))
            } else {
                LoginView()
                    .environmentObject(UserStore(context: sharedModelContainer.mainContext))
            }
        }
        .modelContainer(sharedModelContainer) // Attach the shared ModelContainer
    }
}
