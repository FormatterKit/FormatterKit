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
        XCTAssertEqual(formatter.string(forTimeInterval: -1), "1秒前")
        XCTAssertEqual(formatter.string(forTimeInterval: -100), "1分钟前")
        XCTAssertEqual(formatter.string(forTimeInterval: -10000), "2小时前")
        XCTAssertEqual(formatter.string(forTimeInterval: -100000), "1天前")
        XCTAssertEqual(formatter.string(forTimeInterval: -200000), "2天前")
        XCTAssertEqual(formatter.string(forTimeInterval: -10000000), "3个月前")
    }

    func testStandardFuture() {
        XCTAssertEqual(formatter.string(forTimeInterval: 1), "1秒后")
        XCTAssertEqual(formatter.string(forTimeInterval: 100), "1分钟后")
        XCTAssertEqual(formatter.string(forTimeInterval: 10000), "2小时后")
        XCTAssertEqual(formatter.string(forTimeInterval: 100000), "1天后")
        XCTAssertEqual(formatter.string(forTimeInterval: 200000), "2天后")
        XCTAssertEqual(formatter.string(forTimeInterval: 10000000), "3个月后")
    }

    func testIdiomaticPast() {
        formatter.usesIdiomaticDeicticExpressions = true
        
        XCTAssertEqual(formatter.string(forTimeInterval: -3600 * 24), "昨天")
        XCTAssertEqual(formatter.string(forTimeInterval: -3600 * 24 * 2), "前天")
        XCTAssertEqual(formatter.string(forTimeInterval: -3600 * 24 * 7), "上周")
        XCTAssertEqual(formatter.string(forTimeInterval: -3600 * 24 * 31), "上月")
        XCTAssertEqual(formatter.string(forTimeInterval: -3600 * 24 * 366), "去年")
        XCTAssertEqual(formatter.string(forTimeInterval: -3600 * 24 * 366 * 2), "前年")
    }
    
    func testIdiomaticFuture() {
        formatter.usesIdiomaticDeicticExpressions = true

        XCTAssertEqual(formatter.string(forTimeInterval: 3600 * 24), "明天")
        XCTAssertEqual(formatter.string(forTimeInterval: 3600 * 24 * 2), "后天")
        XCTAssertEqual(formatter.string(forTimeInterval: 3600 * 24 * 7), "下周")
        XCTAssertEqual(formatter.string(forTimeInterval: 3600 * 24 * 31), "下月")
        XCTAssertEqual(formatter.string(forTimeInterval: 3600 * 24 * 366), "明年")
        XCTAssertEqual(formatter.string(forTimeInterval: 3600 * 24 * 366 * 2), "后年")
    }
    
}
