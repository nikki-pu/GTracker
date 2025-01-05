import SwiftUI

struct LoginView: View {
    @State private var username: String = ""
    @State private var password: String = ""
    @State private var errorMessage: String = ""
//    @State private var isAuthenticated: Bool = false // State to track authentication
    @AppStorage("isAuthenticated") private var isAuthenticated: Bool = false

    var body: some View {
        NavigationStack {
            VStack(spacing: 20) {
                Text("Grade Tracker")
                    .font(.largeTitle)
                    .bold()

                TextField("Username", text: $username)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding()

                SecureField("Password", text: $password)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding()

                Button("Log In") {
                    authenticateUser()
                }
                .font(.headline)
                .frame(maxWidth: .infinity)
                .padding()
                .background(Color.blue)
                .foregroundColor(.white)
                .cornerRadius(10)

                if !errorMessage.isEmpty {
                    Text(errorMessage)
                        .foregroundColor(.red)
                        .padding()
                }
            }
            .padding()
            // Define a navigation destination for isAuthenticated
            .navigationDestination(isPresented: $isAuthenticated) {
                ContentView() // Navigate to ContentView
            }
        }
    }

    private func authenticateUser() {
        guard let url = URL(string: "https://frisco-isdhacapi-gray.vercel.app/api/info") else {
            print("Invalid URL")
            return
        }

        var request = URLRequest(url: url)
        request.httpMethod = "GET"

        // Add query parameters for username and password
        let queryItems = [
            URLQueryItem(name: "username", value: username),
            URLQueryItem(name: "password", value: password)
        ]
        if var components = URLComponents(url: url, resolvingAgainstBaseURL: false) {
            components.queryItems = queryItems
            request.url = components.url
        }

        URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                print("Network Error: \(error.localizedDescription)")
                DispatchQueue.main.async {
                    errorMessage = "Network error: \(error.localizedDescription)"
                }
                return
            }

            guard let data = data else {
                print("No data received")
                DispatchQueue.main.async {
                    errorMessage = "Invalid credentials"
                }
                return
            }

            do {
                if let jsonResponse = try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any],
                   let id = jsonResponse["id"] as? String {
                    DispatchQueue.main.async {
                        isAuthenticated = true // Set authentication state to true
                        UserDefaults.standard.set(true, forKey: "isAuthenticated")
                        errorMessage = "" // Clear error message
                    }
                } else {
                    DispatchQueue.main.async {
                        errorMessage = "Invalid response format"
                    }
                }
            } catch {
                DispatchQueue.main.async {
                    errorMessage = "Failed to parse response: \(error.localizedDescription)"
                }
            }
        }.resume()
    }
}
