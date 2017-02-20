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
        XCTAssertEqual(formatter.string(forTimeInterval: -1), "vor 1 Sekunde")
        XCTAssertEqual(formatter.string(forTimeInterval: -100), "vor 1 Minute")
        XCTAssertEqual(formatter.string(forTimeInterval: -10000), "vor 2 Stunden")
        XCTAssertEqual(formatter.string(forTimeInterval: -100000), "vor 1 Tag")
        XCTAssertEqual(formatter.string(forTimeInterval: -200000), "vor 2 Tage")
        XCTAssertEqual(formatter.string(forTimeInterval: -10000000), "vor 3 Monaten")
    }

    func testStandardFuture() {
        XCTAssertEqual(formatter.string(forTimeInterval: 1), "in 1 Sekunde")
        XCTAssertEqual(formatter.string(forTimeInterval: 100), "in 1 Minute")
        XCTAssertEqual(formatter.string(forTimeInterval: 10000), "in 2 Stunden")
        XCTAssertEqual(formatter.string(forTimeInterval: 100000), "in 1 Tag")
        XCTAssertEqual(formatter.string(forTimeInterval: 200000), "in 2 Tage")
        XCTAssertEqual(formatter.string(forTimeInterval: 10000000), "in 3 Monaten")
    }

    func testIdiomaticPast() {
        formatter.usesIdiomaticDeicticExpressions = true

        XCTAssertEqual(formatter.string(forTimeInterval: -1), "vor 1 Sekunde")
        XCTAssertEqual(formatter.string(forTimeInterval: -100), "vor 1 Minute")
        XCTAssertEqual(formatter.string(forTimeInterval: -10000), "vor 2 Stunden")
        XCTAssertEqual(formatter.string(forTimeInterval: -100000), "vor 1 Tag")
        XCTAssertEqual(formatter.string(forTimeInterval: -200000), "vor 2 Tage")
        XCTAssertEqual(formatter.string(forTimeInterval: -10000000), "vor 3 Monaten")
    }
    
}
