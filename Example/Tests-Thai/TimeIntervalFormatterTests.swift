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
        XCTAssertEqual(formatter.string(forTimeInterval: -1), "1 วินาทีที่แล้ว")
        XCTAssertEqual(formatter.string(forTimeInterval: -100), "1 นาทีที่แล้ว")
        XCTAssertEqual(formatter.string(forTimeInterval: -10000), "2 ชั่วโมงที่แล้ว")
        XCTAssertEqual(formatter.string(forTimeInterval: -100000), "1 วันที่แล้ว")
        XCTAssertEqual(formatter.string(forTimeInterval: -200000), "2 วันที่แล้ว")
        XCTAssertEqual(formatter.string(forTimeInterval: -10000000), "3 เดือนที่แล้ว")
    }

    func testStandardFuture() {
        XCTAssertEqual(formatter.string(forTimeInterval: 1), "1 วินาทีจากตอนนี้")
        XCTAssertEqual(formatter.string(forTimeInterval: 100), "1 นาทีจากตอนนี้")
        XCTAssertEqual(formatter.string(forTimeInterval: 10000), "2 ชั่วโมงจากตอนนี้")
        XCTAssertEqual(formatter.string(forTimeInterval: 100000), "1 วันจากตอนนี้")
        XCTAssertEqual(formatter.string(forTimeInterval: 200000), "2 วันจากตอนนี้")
        XCTAssertEqual(formatter.string(forTimeInterval: 10000000), "3 เดือนจากตอนนี้")
    }

    func testIdiomaticPast() {
        formatter.usesIdiomaticDeicticExpressions = true

        XCTAssertEqual(formatter.string(forTimeInterval: -1), "1 วินาทีที่แล้ว")
        XCTAssertEqual(formatter.string(forTimeInterval: -100), "1 นาทีที่แล้ว")
        XCTAssertEqual(formatter.string(forTimeInterval: -10000), "2 ชั่วโมงที่แล้ว")
        XCTAssertEqual(formatter.string(forTimeInterval: -100000), "1 วันที่แล้ว")
        XCTAssertEqual(formatter.string(forTimeInterval: -200000), "2 วันที่แล้ว")
        XCTAssertEqual(formatter.string(forTimeInterval: -10000000), "3 เดือนที่แล้ว")
    }
    
}
