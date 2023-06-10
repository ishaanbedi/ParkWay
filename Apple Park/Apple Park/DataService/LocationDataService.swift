import Foundation
import MapKit

class LocationsDataService {
    static var locations: [Location] = [
        Location(
            name: "Steve Jobs Theater",
            coordinates: CLLocationCoordinate2D(latitude: 37.33087, longitude: -122.00746),
            descriptionText: "The Steve Jobs Theater is a circular theater located at Apple Park, the corporate headquarters of Apple Inc., in Cupertino, California. It is named after Steve Jobs, the co-founder and former CEO of Apple. The theater is used for hosting Apple's special events and product launches.",
            imageNames: ["jobs-theater-1", "jobs-theater-2", "jobs-theater-3"]
        ),
        Location(
            name: "Apple Park Visitor Center",
            coordinates: CLLocationCoordinate2D(latitude: 37.3328, longitude: -122.0054),
            descriptionText: "The Apple Park Visitor Center is a public visitor center at Apple Park, featuring an Apple Store, a café, and exhibition space showcasing Apple products and designs. Visitors can explore the state-of-the-art facility and learn more about Apple's innovative work.",
            imageNames: ["visitor-center-1", "visitor-center-2", "visitor-center-3"]
        ),
        Location(
            name: "Apple Park",
            coordinates: CLLocationCoordinate2D(latitude: 37.3346, longitude: -122.0090),
            descriptionText: "Apple Park is the corporate headquarters of Apple Inc., located in Cupertino, California. The campus covers an area of 175 acres and is designed to be a futuristic, energy-efficient complex surrounded by orchards, meadows, and a central park. It houses various office buildings, research and development facilities, and the iconic Apple Ring, a circular main building.",
            imageNames: ["apple-park-1", "apple-park-2", "apple-park-3"]
        ),
        Location(
            name: "Apple Park Wellness Center",
            coordinates: CLLocationCoordinate2D(latitude: 37.3329, longitude: -122.0055),
            descriptionText: "The Apple Park Wellness Center is a state-of-the-art facility dedicated to the health and well-being of Apple employees. It offers a variety of fitness amenities, including gyms, swimming pools, yoga studios, and wellness programs. The center promotes a healthy lifestyle and work-life balance.",
            imageNames: ["wellness-center-1", "wellness-center-2", "wellness-center-3"]
        ),
        Location(
            name: "Apple Park Cafe",
            coordinates: CLLocationCoordinate2D(latitude: 37.3352, longitude: -122.0096),
            descriptionText: "The Apple Park Cafe is a dining facility located at Apple Park, offering a variety of culinary options for employees and visitors. The cafe features a modern design and serves fresh, healthy meals made with locally sourced ingredients. It provides a vibrant and communal dining experience.",
            imageNames: ["cafe-1", "cafe-2", "cafe-3"]
        )
    ]
}
