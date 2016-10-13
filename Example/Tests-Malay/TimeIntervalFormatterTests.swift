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
        XCTAssertEqual(formatter.string(forTimeInterval: -1), "1 saat lepas")
        XCTAssertEqual(formatter.string(forTimeInterval: -100), "1 minit lepas")
        XCTAssertEqual(formatter.string(forTimeInterval: -10000), "2 jam lepas")
        XCTAssertEqual(formatter.string(forTimeInterval: -100000), "1 hari lepas")
        XCTAssertEqual(formatter.string(forTimeInterval: -200000), "2 hari lepas")
        XCTAssertEqual(formatter.string(forTimeInterval: -10000000), "3 bulan lepas")
    }

    func testStandardFuture() {
        XCTAssertEqual(formatter.string(forTimeInterval: 1), "1 saat dari sekarang")
        XCTAssertEqual(formatter.string(forTimeInterval: 100), "1 minit dari sekarang")
        XCTAssertEqual(formatter.string(forTimeInterval: 10000), "2 jam dari sekarang")
        XCTAssertEqual(formatter.string(forTimeInterval: 100000), "1 hari dari sekarang")
        XCTAssertEqual(formatter.string(forTimeInterval: 200000), "2 hari dari sekarang")
        XCTAssertEqual(formatter.string(forTimeInterval: 10000000), "3 bulan dari sekarang")
    }

    func testIdiomaticPast() {
        formatter.usesIdiomaticDeicticExpressions = true

        XCTAssertEqual(formatter.string(forTimeInterval: -1), "1 saat lepas")
        XCTAssertEqual(formatter.string(forTimeInterval: -100), "1 minit lepas")
        XCTAssertEqual(formatter.string(forTimeInterval: -10000), "2 jam lepas")
        XCTAssertEqual(formatter.string(forTimeInterval: -100000), "1 hari lepas")
        XCTAssertEqual(formatter.string(forTimeInterval: -200000), "2 hari lepas")
        XCTAssertEqual(formatter.string(forTimeInterval: -10000000), "3 bulan lepas")
    }
    
}
