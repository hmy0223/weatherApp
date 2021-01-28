

import Foundation

struct City: Codable {
    let id: Int
    let name, state, country: String
    let coord: Coord
}
struct Coord: Codable {
    let lon, lat: Double
}


extension City {
    static func cities() -> [City] {
        guard
            let url = Bundle.main.url(forResource: "cityList", withExtension: "json"),
            let data = try? Data(contentsOf: url)
        else {
            return []
        }
        
        do {
            let decoder = JSONDecoder()
            return try decoder.decode([City].self, from: data)
        } catch {
            return []
        }
    }
}
extension City: Equatable {
    static func == (lhs: City, rhs: City) -> Bool {
        lhs.name == rhs.name
    }
}
