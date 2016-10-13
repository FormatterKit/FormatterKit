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
        XCTAssertEqual(formatter.string(forTimeInterval: -1), "1 detik yang lalu")
        XCTAssertEqual(formatter.string(forTimeInterval: -100), "1 menit yang lalu")
        XCTAssertEqual(formatter.string(forTimeInterval: -10000), "2 jam yang lalu")
        XCTAssertEqual(formatter.string(forTimeInterval: -100000), "1 hari yang lalu")
        XCTAssertEqual(formatter.string(forTimeInterval: -200000), "2 hari yang lalu")
        XCTAssertEqual(formatter.string(forTimeInterval: -10000000), "3 bulan yang lalu")
    }

    func testStandardFuture() {
        XCTAssertEqual(formatter.string(forTimeInterval: 1), "1 detik dari sekarang")
        XCTAssertEqual(formatter.string(forTimeInterval: 100), "1 menit dari sekarang")
        XCTAssertEqual(formatter.string(forTimeInterval: 10000), "2 jam dari sekarang")
        XCTAssertEqual(formatter.string(forTimeInterval: 100000), "1 hari dari sekarang")
        XCTAssertEqual(formatter.string(forTimeInterval: 200000), "2 hari dari sekarang")
        XCTAssertEqual(formatter.string(forTimeInterval: 10000000), "3 bulan dari sekarang")
    }

    func testIdiomaticPast() {
        formatter.usesIdiomaticDeicticExpressions = true

        XCTAssertEqual(formatter.string(forTimeInterval: -1), "1 detik yang lalu")
        XCTAssertEqual(formatter.string(forTimeInterval: -100), "1 menit yang lalu")
        XCTAssertEqual(formatter.string(forTimeInterval: -10000), "2 jam yang lalu")
        XCTAssertEqual(formatter.string(forTimeInterval: -100000), "1 hari yang lalu")
        XCTAssertEqual(formatter.string(forTimeInterval: -200000), "2 hari yang lalu")
        XCTAssertEqual(formatter.string(forTimeInterval: -10000000), "3 bulan yang lalu")
    }
    
}
