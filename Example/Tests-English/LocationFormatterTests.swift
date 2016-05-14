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
        let result = formatter.stringFromDistanceFromLocation(pittsburgh, toLocation: austin)
        XCTAssertEqual(result, "1,200 miles")
    }

    func testDistanceAndBearing() {
        let result = formatter.stringFromDistanceAndBearingFromLocation(pittsburgh, toLocation: austin)
        XCTAssertEqual(result, "1,200 miles Southwest")
    }

    func testDistanceInMetric() {
        formatter.unitSystem = .MetricSystem
        let result = formatter.stringFromDistanceFromLocation(pittsburgh, toLocation: austin)
        XCTAssertEqual(result, "2,000 km")
    }

    func testDistanceInImperialUnitswithCardinalDirectionAbbreviations() {
        formatter.numberFormatter.maximumSignificantDigits = 4
        formatter.bearingStyle = .BearingAbbreviationWordStyle

        let result = formatter.stringFromDistanceAndBearingFromLocation(pittsburgh, toLocation: austin)
        XCTAssertEqual(result, "1,220 miles SW")
    }

    // TODO: might be a bug as it returns `56 mph`
    func pending_testSpeed() {
        XCTAssertEqual(formatter.stringFromSpeed(25), "25 mph")
    }

    // TODO: returns 240 which doesn't match with the example in readme. Might be a bug
    func pending_testBearingInDegrees() {
        formatter.bearingStyle = .BearingNumericStyle

        XCTAssertEqual(formatter.stringFromBearingFromLocation(pittsburgh, toLocation: austin), "310°")
    }

    func testCoordinates() {
        formatter.numberFormatter.maximumSignificantDigits = 9
        XCTAssertEqual(formatter.stringFromLocation(austin), "30.2669444, -97.7427778")
    }

}
