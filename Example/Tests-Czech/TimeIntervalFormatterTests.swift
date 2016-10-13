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
        XCTAssertEqual(formatter.string(forTimeInterval: -1), "před 1 sekunda")
        XCTAssertEqual(formatter.string(forTimeInterval: -100), "před 1 minuta")
        XCTAssertEqual(formatter.string(forTimeInterval: -10000), "před 2 hodiny")
        XCTAssertEqual(formatter.string(forTimeInterval: -100000), "před 1 den")
        XCTAssertEqual(formatter.string(forTimeInterval: -200000), "před 2 dny")
        XCTAssertEqual(formatter.string(forTimeInterval: -10000000), "před 3 měsíce")
    }

    func testStandardFuture() {
        XCTAssertEqual(formatter.string(forTimeInterval: 1), "za 1 sekunda")
        XCTAssertEqual(formatter.string(forTimeInterval: 100), "za 1 minuta")
        XCTAssertEqual(formatter.string(forTimeInterval: 10000), "za 2 hodiny")
        XCTAssertEqual(formatter.string(forTimeInterval: 100000), "za 1 den")
        XCTAssertEqual(formatter.string(forTimeInterval: 200000), "za 2 dny")
        XCTAssertEqual(formatter.string(forTimeInterval: 10000000), "za 3 měsíce")
    }

    func testIdiomaticPast() {
        formatter.usesIdiomaticDeicticExpressions = true

        XCTAssertEqual(formatter.string(forTimeInterval: -1), "před 1 sekunda")
        XCTAssertEqual(formatter.string(forTimeInterval: -100), "před 1 minuta")
        XCTAssertEqual(formatter.string(forTimeInterval: -10000), "před 2 hodiny")
        XCTAssertEqual(formatter.string(forTimeInterval: -100000), "včera")
        XCTAssertEqual(formatter.string(forTimeInterval: -200000), "předevčírem")
        XCTAssertEqual(formatter.string(forTimeInterval: -10000000), "před 3 měsíce")
    }
    
}
