//
//  LocationFormatterTests.swift
//  FormatterKit Example
//
//  Created by Barış Özdağ on 25.04.2017.
//
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
        XCTAssertEqual(result, "2.000 km")
    }
    
    func testDistanceAndBearing() {
        let result = formatter.stringFromDistanceAndBearing(from: pittsburgh, to: austin)
        XCTAssertEqual(result, "2.000 km Güneybatı")
    }
    
    func testDistanceInMetricUnitswithCardinalDirectionAbbreviations() {
        formatter.numberFormatter.maximumSignificantDigits = 4
        formatter.bearingStyle = .bearingAbbreviationWordStyle
        
        let result = formatter.stringFromDistanceAndBearing(from: pittsburgh, to: austin)
        XCTAssertEqual(result, "1.963 km GB")
    }
    
    func testDistanceInImperialUnit() {
        formatter.unitSystem = .imperialSystem
        let result = formatter.stringFromDistance(from: pittsburgh, to: austin)
        XCTAssertEqual(result, "1.200 mil")
    }
    
    // TODO: might be a bug as it returns `56 mph`
    func pending_testSpeed() {
        XCTAssertEqual(formatter.string(fromSpeed: 25), "25 km/sa")
    }
    
    // TODO: returns 240 which doesn't match with the example in readme. Might be a bug
    func pending_testBearingInDegrees() {
        formatter.bearingStyle = .bearingNumericStyle
        
        XCTAssertEqual(formatter.stringFromBearing(from: pittsburgh, to: austin), "310°")
    }
    
    func testCoordinates() {
        formatter.numberFormatter.maximumSignificantDigits = 9
        XCTAssertEqual(formatter.string(from: austin), "30,2669444, -97,7427778")
    }
    
}
