//
//  weatherAppTests.swift
//  weatherAppTests
//
//  Created by Ho Man Yee on 19/1/2021.
//

import XCTest
@testable import weatherApp

class weatherAppTests: XCTestCase {
    var sut: CitySearcher!
    override func setUpWithError() throws {
        let bundle = Bundle(for: type(of: self))
        let url = bundle.url(forResource: "MockCityList", withExtension: "json")
        let data = try? Data(contentsOf: url!)
        let jsonDecoder = JSONDecoder()
        let cities = try! jsonDecoder.decode([City].self, from: data!)
        sut = CitySearcher(cities: cities)
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testEmptySearchTextReturnsAllCities() throws {
        //given a list of cities
        let expected = sut.cities
        //when it is a empty search text
        let actual = sut.search(city: "")
        //then should return all cities
        XCTAssertEqual(expected, actual)
        
    }
    func testSearchTextHongKongCaseInsensitiveReturnsHongKong() throws {
        //given a list of cities
        let expected = [City(id: 0, name: "Hong Kong", state: "fake", country:"HK", coord: Coord(lon: 000, lat: 000))]
        //when search text is "hong kong"
        let actual = sut.search(city: "hong kong")
        print(actual)
        //then should return hong kong only
        XCTAssertEqual(expected, actual)
    }
    func testSearchTextRubbishCaseInsensitiveReturnsRubbish() throws {
        //given a list of cities
        let expected = [City(id: 0, name: "Rubbish", state: "23fj", country:"HK", coord: Coord(lon: 000, lat: 000))]
        //when search text is "hong kong"
        let actual = sut.search(city: "Rubbish")
        //then should return hong kong only
        XCTAssertEqual(expected, actual)
    }
    

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
