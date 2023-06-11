import Foundation
import SwiftData
import MapKit


@Model
class SavedLocationSDModel {
    let name: String
    let descriptionText: String
    let imageNames: [String]
    let notes: String

    init(name: String, descriptionText: String, imageNames: [String], notes: String) {
        self.name = name
        self.descriptionText = descriptionText
        self.imageNames = imageNames
        self.notes = notes
    }
}
