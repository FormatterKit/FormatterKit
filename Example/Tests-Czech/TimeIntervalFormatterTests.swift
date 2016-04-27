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
        XCTAssertEqual(formatter.stringForTimeInterval(-1), "před 1 sekunda")
        XCTAssertEqual(formatter.stringForTimeInterval(-100), "před 1 minuta")
        XCTAssertEqual(formatter.stringForTimeInterval(-10000), "před 2 hodiny")
        XCTAssertEqual(formatter.stringForTimeInterval(-100000), "před 1 den")
        XCTAssertEqual(formatter.stringForTimeInterval(-200000), "před 2 dny")
        XCTAssertEqual(formatter.stringForTimeInterval(-10000000), "před 3 měsíce")
    }

    func testStandardFuture() {
        XCTAssertEqual(formatter.stringForTimeInterval(1), "za 1 sekunda")
        XCTAssertEqual(formatter.stringForTimeInterval(100), "za 1 minuta")
        XCTAssertEqual(formatter.stringForTimeInterval(10000), "za 2 hodiny")
        XCTAssertEqual(formatter.stringForTimeInterval(100000), "za 1 den")
        XCTAssertEqual(formatter.stringForTimeInterval(200000), "za 2 dny")
        XCTAssertEqual(formatter.stringForTimeInterval(10000000), "za 3 měsíce")
    }

    func testIdiomaticPast() {
        formatter.usesIdiomaticDeicticExpressions = true

        XCTAssertEqual(formatter.stringForTimeInterval(-1), "před 1 sekunda")
        XCTAssertEqual(formatter.stringForTimeInterval(-100), "před 1 minuta")
        XCTAssertEqual(formatter.stringForTimeInterval(-10000), "před 2 hodiny")
        XCTAssertEqual(formatter.stringForTimeInterval(-100000), "včera")
        XCTAssertEqual(formatter.stringForTimeInterval(-200000), "předevčírem")
        XCTAssertEqual(formatter.stringForTimeInterval(-10000000), "před 3 měsíce")
    }
    
}
