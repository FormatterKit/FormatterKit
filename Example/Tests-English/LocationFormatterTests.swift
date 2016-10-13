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

    func testDistance() {
        let result = formatter.stringFromDistance(from: pittsburgh, to: austin)
        XCTAssertEqual(result, "1,200 miles")
    }

    func testDistanceAndBearing() {
        let result = formatter.stringFromDistanceAndBearing(from: pittsburgh, to: austin)
        XCTAssertEqual(result, "1,200 miles Southwest")
    }

    func testDistanceInMetric() {
        formatter.unitSystem = .metricSystem
        let result = formatter.stringFromDistance(from: pittsburgh, to: austin)
        XCTAssertEqual(result, "2,000 km")
    }

    func testDistanceInImperialUnitswithCardinalDirectionAbbreviations() {
        formatter.numberFormatter.maximumSignificantDigits = 4
        formatter.bearingStyle = .bearingAbbreviationWordStyle

        let result = formatter.stringFromDistanceAndBearing(from: pittsburgh, to: austin)
        XCTAssertEqual(result, "1,220 miles SW")
    }

    // TODO: might be a bug as it returns `56 mph`
    func pending_testSpeed() {
        XCTAssertEqual(formatter.string(fromSpeed: 25), "25 mph")
    }

    // TODO: returns 240 which doesn't match with the example in readme. Might be a bug
    func pending_testBearingInDegrees() {
        formatter.bearingStyle = .bearingNumericStyle

        XCTAssertEqual(formatter.stringFromBearing(from: pittsburgh, to: austin), "310°")
    }

    func testCoordinates() {
        formatter.numberFormatter.maximumSignificantDigits = 9
        XCTAssertEqual(formatter.string(from: austin), "30.2669444, -97.7427778")
    }

}
