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
        XCTAssertEqual(formatter.stringForTimeInterval(-1), "1 detik yang lalu")
        XCTAssertEqual(formatter.stringForTimeInterval(-100), "1 menit yang lalu")
        XCTAssertEqual(formatter.stringForTimeInterval(-10000), "2 jam yang lalu")
        XCTAssertEqual(formatter.stringForTimeInterval(-100000), "1 hari yang lalu")
        XCTAssertEqual(formatter.stringForTimeInterval(-200000), "2 hari yang lalu")
        XCTAssertEqual(formatter.stringForTimeInterval(-10000000), "3 bulan yang lalu")
    }

    func testStandardFuture() {
        XCTAssertEqual(formatter.stringForTimeInterval(1), "1 detik dari sekarang")
        XCTAssertEqual(formatter.stringForTimeInterval(100), "1 menit dari sekarang")
        XCTAssertEqual(formatter.stringForTimeInterval(10000), "2 jam dari sekarang")
        XCTAssertEqual(formatter.stringForTimeInterval(100000), "1 hari dari sekarang")
        XCTAssertEqual(formatter.stringForTimeInterval(200000), "2 hari dari sekarang")
        XCTAssertEqual(formatter.stringForTimeInterval(10000000), "3 bulan dari sekarang")
    }

    func testIdiomaticPast() {
        formatter.usesIdiomaticDeicticExpressions = true

        XCTAssertEqual(formatter.stringForTimeInterval(-1), "1 detik yang lalu")
        XCTAssertEqual(formatter.stringForTimeInterval(-100), "1 menit yang lalu")
        XCTAssertEqual(formatter.stringForTimeInterval(-10000), "2 jam yang lalu")
        XCTAssertEqual(formatter.stringForTimeInterval(-100000), "1 hari yang lalu")
        XCTAssertEqual(formatter.stringForTimeInterval(-200000), "2 hari yang lalu")
        XCTAssertEqual(formatter.stringForTimeInterval(-10000000), "3 bulan yang lalu")
    }
    
}
