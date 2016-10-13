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
        XCTAssertEqual(formatter.string(forTimeInterval: -1), "1 ثانية منذ")
        XCTAssertEqual(formatter.string(forTimeInterval: -100), "1 دقيقة منذ")
        XCTAssertEqual(formatter.string(forTimeInterval: -10000), "2 ساعات منذ")
        XCTAssertEqual(formatter.string(forTimeInterval: -100000), "1 يوم منذ")
        XCTAssertEqual(formatter.string(forTimeInterval: -200000), "2 ايام منذ")
        XCTAssertEqual(formatter.string(forTimeInterval: -10000000), "3 اشهر منذ")
    }

    func testStandardFuture() {
        XCTAssertEqual(formatter.string(forTimeInterval: 1), "1 ثانية منذ الآن")
        XCTAssertEqual(formatter.string(forTimeInterval: 100), "1 دقيقة منذ الآن")
        XCTAssertEqual(formatter.string(forTimeInterval: 10000), "2 ساعات منذ الآن")
        XCTAssertEqual(formatter.string(forTimeInterval: 100000), "1 يوم منذ الآن")
        XCTAssertEqual(formatter.string(forTimeInterval: 200000), "2 ايام منذ الآن")
        XCTAssertEqual(formatter.string(forTimeInterval: 10000000), "3 اشهر منذ الآن")
    }

    func testIdiomaticPast() {
        formatter.usesIdiomaticDeicticExpressions = true

        XCTAssertEqual(formatter.string(forTimeInterval: -1), "1 ثانية منذ")
        XCTAssertEqual(formatter.string(forTimeInterval: -100), "1 دقيقة منذ")
        XCTAssertEqual(formatter.string(forTimeInterval: -10000), "2 ساعات منذ")
        XCTAssertEqual(formatter.string(forTimeInterval: -100000), "1 يوم منذ")
        XCTAssertEqual(formatter.string(forTimeInterval: -200000), "2 ايام منذ")
        XCTAssertEqual(formatter.string(forTimeInterval: -10000000), "3 اشهر منذ")
    }
    
}
