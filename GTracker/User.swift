import SwiftData

@Model
class User {
    var id: String
    var name: String
    var birthdate: String
    var campus: String
    var grade: String
    var counselor: String
    var totalCredits: String

    init(id: String, name: String, birthdate: String, campus: String, grade: String, counselor: String, totalCredits: String) {
        self.id = id
        self.name = name
        self.birthdate = birthdate
        self.campus = campus
        self.grade = grade
        self.counselor = counselor
        self.totalCredits = totalCredits
    }
}
