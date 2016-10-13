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
        XCTAssertEqual(formatter.string(forTimeInterval: -1), "1 másodperc óta")
        XCTAssertEqual(formatter.string(forTimeInterval: -100), "1 perc óta")
        XCTAssertEqual(formatter.string(forTimeInterval: -10000), "2 óra óta")
        XCTAssertEqual(formatter.string(forTimeInterval: -100000), "1 nap óta")
        XCTAssertEqual(formatter.string(forTimeInterval: -200000), "2 nap óta")
        XCTAssertEqual(formatter.string(forTimeInterval: -10000000), "3 hónap óta")
    }

    func testStandardFuture() {
        XCTAssertEqual(formatter.string(forTimeInterval: 1), "1 másodperc múlva")
        XCTAssertEqual(formatter.string(forTimeInterval: 100), "1 perc múlva")
        XCTAssertEqual(formatter.string(forTimeInterval: 10000), "2 óra múlva")
        XCTAssertEqual(formatter.string(forTimeInterval: 100000), "1 nap múlva")
        XCTAssertEqual(formatter.string(forTimeInterval: 200000), "2 nap múlva")
        XCTAssertEqual(formatter.string(forTimeInterval: 10000000), "3 hónap múlva")
    }

    func testIdiomaticPast() {
        formatter.usesIdiomaticDeicticExpressions = true

        XCTAssertEqual(formatter.string(forTimeInterval: -1), "1 másodperc óta")
        XCTAssertEqual(formatter.string(forTimeInterval: -100), "1 perc óta")
        XCTAssertEqual(formatter.string(forTimeInterval: -10000), "2 óra óta")
        XCTAssertEqual(formatter.string(forTimeInterval: -100000), "tegnap")
        XCTAssertEqual(formatter.string(forTimeInterval: -200000), "tegnapelőtt")
        XCTAssertEqual(formatter.string(forTimeInterval: -10000000), "3 hónap óta")
    }
    
}
