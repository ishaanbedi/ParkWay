import Foundation
import SwiftData
import MapKit


@Model
class SavedLocationSDModel {
    let name: String
    let descriptionText: String
    let imageNames: [String]
    init(name: String, descriptionText: String, imageNames: [String]) {
        self.name = name
        self.descriptionText = descriptionText
        self.imageNames = imageNames
    }
}
