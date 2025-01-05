import SwiftUI
import SwiftData

@Observable
class UserStore: ObservableObject {
    // Remove @Environment and inject ModelContext manually in the initializer
    private let modelContext: ModelContext
    var currentUser: User?

    init(context: ModelContext) {
        self.modelContext = context
        self.loadUser()
    }

    // Save user to persistent store
    func saveUser(_ user: User) {
        modelContext.insert(user)
        currentUser = user
        do {
            try modelContext.save()
        } catch {
            print("Error saving user: \(error)")
        }
    }

    // Load user from persistent store
    func loadUser() {
        do {
            let users = try modelContext.fetch(FetchDescriptor<User>())
            currentUser = users.first // Assuming a single user
        } catch {
            print("Error loading user: \(error)")
        }
    }

    // Clear user data
    func clearUser() {
        if let user = currentUser {
            modelContext.delete(user)
            do {
                try modelContext.save()
                currentUser = nil
            } catch {
                print("Error clearing user: \(error)")
            }
        }
    }
}
