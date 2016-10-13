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
        XCTAssertEqual(formatter.string(forTimeInterval: -1), "1 sekund sedan")
        XCTAssertEqual(formatter.string(forTimeInterval: -100), "1 minut sedan")
        XCTAssertEqual(formatter.string(forTimeInterval: -10000), "2 timmar sedan")
        XCTAssertEqual(formatter.string(forTimeInterval: -100000), "1 dag sedan")
        XCTAssertEqual(formatter.string(forTimeInterval: -200000), "2 dagar sedan")
        XCTAssertEqual(formatter.string(forTimeInterval: -10000000), "3 månader sedan")
    }

    func testStandardFuture() {
        XCTAssertEqual(formatter.string(forTimeInterval: 1), "1 sekund från nu")
        XCTAssertEqual(formatter.string(forTimeInterval: 100), "1 minut från nu")
        XCTAssertEqual(formatter.string(forTimeInterval: 10000), "2 timmar från nu")
        XCTAssertEqual(formatter.string(forTimeInterval: 100000), "1 dag från nu")
        XCTAssertEqual(formatter.string(forTimeInterval: 200000), "2 dagar från nu")
        XCTAssertEqual(formatter.string(forTimeInterval: 10000000), "3 månader från nu")
    }

    func testIdiomaticPast() {
        formatter.usesIdiomaticDeicticExpressions = true

        XCTAssertEqual(formatter.string(forTimeInterval: -1), "1 sekund sedan")
        XCTAssertEqual(formatter.string(forTimeInterval: -100), "1 minut sedan")
        XCTAssertEqual(formatter.string(forTimeInterval: -10000), "2 timmar sedan")
        XCTAssertEqual(formatter.string(forTimeInterval: -100000), "1 dag sedan")
        XCTAssertEqual(formatter.string(forTimeInterval: -200000), "2 dagar sedan")
        XCTAssertEqual(formatter.string(forTimeInterval: -10000000), "3 månader sedan")
    }
    
}
