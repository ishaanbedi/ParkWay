import Foundation
import MapKit

struct StationLocation: Identifiable, Equatable {

    let id: String = UUID().uuidString
    let name: String
    let coordinates: CLLocationCoordinate2D

    static func == (lhs: StationLocation, rhs: StationLocation) -> Bool {
        return lhs.id == rhs.id
    }

}

class LocationDataService {
    static let list: [StationLocation] = [
        StationLocation(name: "AIIMS", coordinates: CLLocationCoordinate2D(latitude: 28.5649, longitude: 77.2077)),
        StationLocation(name: "Adarsh Nagar", coordinates: CLLocationCoordinate2D(latitude: 28.7172, longitude: 77.1700)),
        StationLocation(name: "Airport", coordinates: CLLocationCoordinate2D(latitude: 28.5539, longitude: 77.0849)),
        StationLocation(name: "Akshardham", coordinates: CLLocationCoordinate2D(latitude: 28.6127, longitude: 77.2773)),
        StationLocation(name: "Alpha 1", coordinates: CLLocationCoordinate2D(latitude: 28.4704, longitude: 77.5038)),
    ]
}
