//
//  ScheduleView.swift
//  Grade Tracker (actually final)
//
//  Created by Swetha Panyam on 12/30/24.
//

import SwiftUI

struct ScheduleView: View {
    @State private var schedule: [String] = [] // Example: ["Math - Period 1", "English - Period 2"]
    @State private var errorMessage: String = ""

    var body: some View {
        VStack {
            if !schedule.isEmpty {
                List(schedule, id: \.self) { classInfo in
                    Text(classInfo)
                }
            } else {
                Text(errorMessage.isEmpty ? "Loading schedule..." : errorMessage)
                    .foregroundColor(.red)
            }
        }
        .onAppear {
            fetchSchedule()
        }
        .navigationTitle("Schedule")
    }

    private func fetchSchedule() {
        guard let url = URL(string: "https://frisco-isdhacapi-gray.vercel.app/schedule") else { return }

        URLSession.shared.dataTask(with: url) { data, _, error in
            if let error = error {
                DispatchQueue.main.async {
                    errorMessage = "Error: \(error.localizedDescription)"
                }
                return
            }

            if let data = data, let fetchedSchedule = try? JSONDecoder().decode([String].self, from: data) {
                DispatchQueue.main.async {
                    schedule = fetchedSchedule
                }
            }
        }.resume()
    }
}
