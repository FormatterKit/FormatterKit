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
        XCTAssertEqual(formatter.string(forTimeInterval: -1), "1 δευτερόλεπτο πριν")
        XCTAssertEqual(formatter.string(forTimeInterval: -100), "1 λεπτό πριν")
        XCTAssertEqual(formatter.string(forTimeInterval: -10000), "2 ώρες πριν")
        XCTAssertEqual(formatter.string(forTimeInterval: -100000), "1 μέρα πριν")
        XCTAssertEqual(formatter.string(forTimeInterval: -200000), "2 μέρες πριν")
        XCTAssertEqual(formatter.string(forTimeInterval: -10000000), "3 μήνες πριν")
    }

    func testStandardFuture() {
        XCTAssertEqual(formatter.string(forTimeInterval: 1), "1 δευτερόλεπτο από τώρα")
        XCTAssertEqual(formatter.string(forTimeInterval: 100), "1 λεπτό από τώρα")
        XCTAssertEqual(formatter.string(forTimeInterval: 10000), "2 ώρες από τώρα")
        XCTAssertEqual(formatter.string(forTimeInterval: 100000), "1 μέρα από τώρα")
        XCTAssertEqual(formatter.string(forTimeInterval: 200000), "2 μέρες από τώρα")
        XCTAssertEqual(formatter.string(forTimeInterval: 10000000), "3 μήνες από τώρα")
    }

    func testIdiomaticPast() {
        formatter.usesIdiomaticDeicticExpressions = true

        XCTAssertEqual(formatter.string(forTimeInterval: -1), "1 δευτερόλεπτο πριν")
        XCTAssertEqual(formatter.string(forTimeInterval: -100), "1 λεπτό πριν")
        XCTAssertEqual(formatter.string(forTimeInterval: -10000), "2 ώρες πριν")
        XCTAssertEqual(formatter.string(forTimeInterval: -100000), "1 μέρα πριν")
        XCTAssertEqual(formatter.string(forTimeInterval: -200000), "2 μέρες πριν")
        XCTAssertEqual(formatter.string(forTimeInterval: -10000000), "3 μήνες πριν")
    }
    
}
