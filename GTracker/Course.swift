//
//  Course.swift
//  GTracker
//
//  Created by Govinda Puthalapat on 1/4/25.
//


import SwiftData
import Foundation

@Model
class Course {
    // Properties
    var year: Int
    var tier: Int
    var teacher: String?
    var semester2Grade: Int
    var semester1Grade: Int
    var name: String?
    var id: UUID
    var grade: String?
    var credits: Double

    // Initializer
    init(year: Int, 
         tier: Int, 
         teacher: String? = nil, 
         semester2Grade: Int, 
         semester1Grade: Int, 
         name: String? = nil, 
         grade: String? = nil, 
         credits: Double, 
         id: UUID = UUID()) {
        self.year = year
        self.tier = tier
        self.teacher = teacher
        self.semester2Grade = semester2Grade
        self.semester1Grade = semester1Grade
        self.name = name
        self.grade = grade
        self.credits = credits
        self.id = id
    }
}

// Conformance to Identifiable
extension Course: Identifiable {}
