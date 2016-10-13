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
        XCTAssertEqual(formatter.string(forTimeInterval: -1), "1 sekunda temu")
        XCTAssertEqual(formatter.string(forTimeInterval: -100), "1 minuta temu")
        XCTAssertEqual(formatter.string(forTimeInterval: -10000), "2 godziny temu")
        XCTAssertEqual(formatter.string(forTimeInterval: -100000), "1 dzień temu")
        XCTAssertEqual(formatter.string(forTimeInterval: -200000), "2 dni temu")
        XCTAssertEqual(formatter.string(forTimeInterval: -10000000), "3 miesiące temu")
    }

    func testStandardFuture() {
        XCTAssertEqual(formatter.string(forTimeInterval: 1), "1 sekunda od tego momentu")
        XCTAssertEqual(formatter.string(forTimeInterval: 100), "1 minuta od tego momentu")
        XCTAssertEqual(formatter.string(forTimeInterval: 10000), "2 godziny od tego momentu")
        XCTAssertEqual(formatter.string(forTimeInterval: 100000), "1 dzień od tego momentu")
        XCTAssertEqual(formatter.string(forTimeInterval: 200000), "2 dni od tego momentu")
        XCTAssertEqual(formatter.string(forTimeInterval: 10000000), "3 miesiące od tego momentu")
    }

    func testIdiomaticPast() {
        formatter.usesIdiomaticDeicticExpressions = true

        XCTAssertEqual(formatter.string(forTimeInterval: -1), "1 sekunda temu")
        XCTAssertEqual(formatter.string(forTimeInterval: -100), "1 minuta temu")
        XCTAssertEqual(formatter.string(forTimeInterval: -10000), "2 godziny temu")
        XCTAssertEqual(formatter.string(forTimeInterval: -100000), "wczoraj")
        XCTAssertEqual(formatter.string(forTimeInterval: -200000), "przedwczoraj")
        XCTAssertEqual(formatter.string(forTimeInterval: -10000000), "3 miesiące temu")
    }
    
}
