//
//  TimeIntervalFormatterTests.swift
//  Tests-French
//
//  Created by Victor Ilyukevich on 4/25/16.
//  Copyright © 2016. All rights reserved.
//

import XCTest
import FormatterKit

class TTTTimeIntervalFormatterTests: XCTestCase {
    var formatter: TTTTimeIntervalFormatter!

    override func setUp() {
        super.setUp()
        formatter = TTTTimeIntervalFormatter()
    }

    // MARK: Tests

    func testStandardPast() {
        XCTAssertEqual(formatter.stringForTimeInterval(-1), "il y a 1 seconde")
        XCTAssertEqual(formatter.stringForTimeInterval(-100), "il y a 1 minute")
        XCTAssertEqual(formatter.stringForTimeInterval(-10000), "il y a 2 heures")
        XCTAssertEqual(formatter.stringForTimeInterval(-100000), "il y a 1 jour")
        XCTAssertEqual(formatter.stringForTimeInterval(-200000), "il y a 2 jours")
        XCTAssertEqual(formatter.stringForTimeInterval(-10000000), "il y a 3 mois")
    }

    func testStandardFuture() {
        XCTAssertEqual(formatter.stringForTimeInterval(1), "dans 1 seconde")
        XCTAssertEqual(formatter.stringForTimeInterval(100), "dans 1 minute")
        XCTAssertEqual(formatter.stringForTimeInterval(10000), "dans 2 heures")
        XCTAssertEqual(formatter.stringForTimeInterval(100000), "dans 1 jour")
        XCTAssertEqual(formatter.stringForTimeInterval(200000), "dans 2 jours")
        XCTAssertEqual(formatter.stringForTimeInterval(10000000), "dans 3 mois")
    }

    func testIdiomaticPast() {
        formatter.usesIdiomaticDeicticExpressions = true

        XCTAssertEqual(formatter.stringForTimeInterval(-1), "il y a 1 seconde")
        XCTAssertEqual(formatter.stringForTimeInterval(-100), "il y a 1 minute")
        XCTAssertEqual(formatter.stringForTimeInterval(-10000), "il y a 2 heures")
        XCTAssertEqual(formatter.stringForTimeInterval(-100000), "hier")
        XCTAssertEqual(formatter.stringForTimeInterval(-200000), "il y a 2 jours")
        XCTAssertEqual(formatter.stringForTimeInterval(-10000000), "il y a 3 mois")
    }

}
