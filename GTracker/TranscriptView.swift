//
//  TranscriptView.swift
//  Grade Tracker (actually final)
//
//  Created by Swetha Panyam on 12/30/24.
//

import SwiftUI

struct TranscriptView: View {
    @State private var transcript: [TranscriptEntry] = []
    @State private var errorMessage: String = ""

    var body: some View {
        VStack {
            if !transcript.isEmpty {
                List {
                    ForEach(transcript) { entry in
                        VStack(alignment: .leading) {
                            Text("Year: \(entry.year)")
                                .font(.headline)
                            Text("Weighted GPA: \(String(format: "%.2f", entry.weightedGPA))")
                                .foregroundColor(.blue)
                            Text("Unweighted GPA: \(String(format: "%.2f", entry.unweightedGPA))")
                                .foregroundColor(.green)
                            Text("Credits Earned: \(entry.credits)")
                                .foregroundColor(.secondary)
                        }
                        .padding(.vertical, 8)
                    }
                }
            } else if !errorMessage.isEmpty {
                Text(errorMessage)
                    .foregroundColor(.red)
                    .padding()
            } else {
                ProgressView("Loading Transcript...")
            }
        }
        .navigationTitle("Transcript")
        .onAppear {
            fetchTranscript()
        }
    }

    private func fetchTranscript() {
        guard let url = URL(string: "https://frisco-isdhacapi-gray.vercel.app/info") else {
            errorMessage = "Invalid URL"
            return
        }

        URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                DispatchQueue.main.async {
                    errorMessage = "Error fetching transcript: \(error.localizedDescription)"
                }
                return
            }

            guard let data = data else {
                DispatchQueue.main.async {
                    errorMessage = "No data received from API."
                }
                return
            }

            do {
                let decodedTranscript = try JSONDecoder().decode([TranscriptEntry].self, from: data)
                DispatchQueue.main.async {
                    self.transcript = decodedTranscript
                }
            } catch {
                DispatchQueue.main.async {
                    errorMessage = "Failed to decode transcript data."
                }
            }
        }.resume()
    }
}

// TranscriptEntry model
struct TranscriptEntry: Identifiable, Codable {
    var id = UUID()
    var year: Int
    var weightedGPA: Double
    var unweightedGPA: Double
    var credits: Double
}
