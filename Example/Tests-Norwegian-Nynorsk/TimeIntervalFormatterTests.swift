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
        XCTAssertEqual(formatter.string(forTimeInterval: -1), "1 sekund sidan")
        XCTAssertEqual(formatter.string(forTimeInterval: -100), "1 minutt sidan")
        XCTAssertEqual(formatter.string(forTimeInterval: -10000), "2 timar sidan")
        XCTAssertEqual(formatter.string(forTimeInterval: -100000), "1 dag sidan")
        XCTAssertEqual(formatter.string(forTimeInterval: -200000), "2 dagar sidan")
        XCTAssertEqual(formatter.string(forTimeInterval: -10000000), "3 månader sidan")
    }

    func testStandardFuture() {
        XCTAssertEqual(formatter.string(forTimeInterval: 1), "1 sekund frå no")
        XCTAssertEqual(formatter.string(forTimeInterval: 100), "1 minutt frå no")
        XCTAssertEqual(formatter.string(forTimeInterval: 10000), "2 timar frå no")
        XCTAssertEqual(formatter.string(forTimeInterval: 100000), "1 dag frå no")
        XCTAssertEqual(formatter.string(forTimeInterval: 200000), "2 dagar frå no")
        XCTAssertEqual(formatter.string(forTimeInterval: 10000000), "3 månader frå no")
    }

    func testIdiomaticPast() {
        formatter.usesIdiomaticDeicticExpressions = true

        XCTAssertEqual(formatter.string(forTimeInterval: -1), "1 sekund sidan")
        XCTAssertEqual(formatter.string(forTimeInterval: -100), "1 minutt sidan")
        XCTAssertEqual(formatter.string(forTimeInterval: -10000), "2 timar sidan")
        XCTAssertEqual(formatter.string(forTimeInterval: -100000), "1 dag sidan")
        XCTAssertEqual(formatter.string(forTimeInterval: -200000), "2 dagar sidan")
        XCTAssertEqual(formatter.string(forTimeInterval: -10000000), "3 månader sidan")
    }
    
}
