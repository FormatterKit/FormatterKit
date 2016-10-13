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
        XCTAssertEqual(formatter.string(forTimeInterval: -1), "1 секунда тому")
        XCTAssertEqual(formatter.string(forTimeInterval: -100), "1 хвилина тому")
        XCTAssertEqual(formatter.string(forTimeInterval: -10000), "2 години тому")
        XCTAssertEqual(formatter.string(forTimeInterval: -100000), "1 день тому")
        XCTAssertEqual(formatter.string(forTimeInterval: -200000), "2 days тому")
        XCTAssertEqual(formatter.string(forTimeInterval: -10000000), "3 місяці тому")
    }

    func testStandardFuture() {
        XCTAssertEqual(formatter.string(forTimeInterval: 1), "1 секунда від тепер")
        XCTAssertEqual(formatter.string(forTimeInterval: 100), "1 хвилина від тепер")
        XCTAssertEqual(formatter.string(forTimeInterval: 10000), "2 години від тепер")
        XCTAssertEqual(formatter.string(forTimeInterval: 100000), "1 день від тепер")
        XCTAssertEqual(formatter.string(forTimeInterval: 200000), "2 days від тепер")
        XCTAssertEqual(formatter.string(forTimeInterval: 10000000), "3 місяці від тепер")
    }

    func testIdiomaticPast() {
        formatter.usesIdiomaticDeicticExpressions = true

        XCTAssertEqual(formatter.string(forTimeInterval: -1), "1 секунда тому")
        XCTAssertEqual(formatter.string(forTimeInterval: -100), "1 хвилина тому")
        XCTAssertEqual(formatter.string(forTimeInterval: -10000), "2 години тому")
        XCTAssertEqual(formatter.string(forTimeInterval: -100000), "1 день тому")
        XCTAssertEqual(formatter.string(forTimeInterval: -200000), "2 days тому")
        XCTAssertEqual(formatter.string(forTimeInterval: -10000000), "3 місяці тому")
    }
    
}
