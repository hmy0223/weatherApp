//
//  CityList.swift
//  weatherApp
//
//  Created by Ho Man Yee on 21/1/2021.
//

import Foundation

struct City: Decodable {
  let name: String

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
