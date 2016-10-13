//
//  LocationFormatterTests.swift
//  FormatterKit Example
//
//  Created by Victor Ilyukevich on 5/14/16.
//

import XCTest
import FormatterKit

class LocationFormatterTests: XCTestCase {

    var formatter: TTTLocationFormatter!
    var austin: CLLocation {
        return CLLocation(latitude: 30.2669444, longitude:-97.7427778)
    }
    var pittsburgh: CLLocation {
        return CLLocation(latitude: 40.4405556, longitude:-79.9961111)
    }

    override func setUp() {
        super.setUp()
        formatter = TTTLocationFormatter()
    }

    // MARK: Tests

    func testDistanceAndBearing() {
        let result = formatter.stringFromDistanceAndBearing(from: pittsburgh, to: austin)
        XCTAssertEqual(result, "2 000 км Юго-запад")
    }

}
