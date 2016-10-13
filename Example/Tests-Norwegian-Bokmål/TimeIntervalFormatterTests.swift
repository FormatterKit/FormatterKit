//
//  TTTTimeIntervalFormatterTests.swift
//  FormatterKit
//
//  Created by Victor Ilyukevich on 4/27/16.
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
        XCTAssertEqual(formatter.string(forTimeInterval: -1), "1 sekund siden")
        XCTAssertEqual(formatter.string(forTimeInterval: -100), "1 minutt siden")
        XCTAssertEqual(formatter.string(forTimeInterval: -10000), "2 timer siden")
        XCTAssertEqual(formatter.string(forTimeInterval: -100000), "1 dag siden")
        XCTAssertEqual(formatter.string(forTimeInterval: -200000), "2 dager siden")
        XCTAssertEqual(formatter.string(forTimeInterval: -10000000), "3 måneder siden")
    }

    func testStandardFuture() {
        XCTAssertEqual(formatter.string(forTimeInterval: 1), "1 sekund fra nå")
        XCTAssertEqual(formatter.string(forTimeInterval: 100), "1 minutt fra nå")
        XCTAssertEqual(formatter.string(forTimeInterval: 10000), "2 timer fra nå")
        XCTAssertEqual(formatter.string(forTimeInterval: 100000), "1 dag fra nå")
        XCTAssertEqual(formatter.string(forTimeInterval: 200000), "2 dager fra nå")
        XCTAssertEqual(formatter.string(forTimeInterval: 10000000), "3 måneder fra nå")
    }

    func testIdiomaticPast() {
        formatter.usesIdiomaticDeicticExpressions = true

        XCTAssertEqual(formatter.string(forTimeInterval: -1), "1 sekund siden")
        XCTAssertEqual(formatter.string(forTimeInterval: -100), "1 minutt siden")
        XCTAssertEqual(formatter.string(forTimeInterval: -10000), "2 timer siden")
        XCTAssertEqual(formatter.string(forTimeInterval: -100000), "1 dag siden")
        XCTAssertEqual(formatter.string(forTimeInterval: -200000), "2 dager siden")
        XCTAssertEqual(formatter.string(forTimeInterval: -10000000), "3 måneder siden")
    }
    
}
