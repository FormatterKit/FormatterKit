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
        XCTAssertEqual(formatter.string(forTimeInterval: -100), "1 minut siden")
        XCTAssertEqual(formatter.string(forTimeInterval: -10000), "2 timer siden")
        XCTAssertEqual(formatter.string(forTimeInterval: -100000), "1 dag siden")
        XCTAssertEqual(formatter.string(forTimeInterval: -200000), "2 dage siden")
        XCTAssertEqual(formatter.string(forTimeInterval: -10000000), "3 måneder siden")
    }

    func testStandardFuture() {
        XCTAssertEqual(formatter.string(forTimeInterval: 1), "1 sekund fra nu")
        XCTAssertEqual(formatter.string(forTimeInterval: 100), "1 minut fra nu")
        XCTAssertEqual(formatter.string(forTimeInterval: 10000), "2 timer fra nu")
        XCTAssertEqual(formatter.string(forTimeInterval: 100000), "1 dag fra nu")
        XCTAssertEqual(formatter.string(forTimeInterval: 200000), "2 dage fra nu")
        XCTAssertEqual(formatter.string(forTimeInterval: 10000000), "3 måneder fra nu")
    }

    func testIdiomaticPast() {
        formatter.usesIdiomaticDeicticExpressions = true

        XCTAssertEqual(formatter.string(forTimeInterval: -1), "1 sekund siden")
        XCTAssertEqual(formatter.string(forTimeInterval: -100), "1 minut siden")
        XCTAssertEqual(formatter.string(forTimeInterval: -10000), "2 timer siden")
        XCTAssertEqual(formatter.string(forTimeInterval: -100000), "1 dag siden")
        XCTAssertEqual(formatter.string(forTimeInterval: -200000), "2 dage siden")
        XCTAssertEqual(formatter.string(forTimeInterval: -10000000), "3 måneder siden")
    }
    
}
