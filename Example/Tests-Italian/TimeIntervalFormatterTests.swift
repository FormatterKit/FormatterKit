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
        XCTAssertEqual(formatter.string(forTimeInterval: -1), "1 secondo fa")
        XCTAssertEqual(formatter.string(forTimeInterval: -100), "1 minuto fa")
        XCTAssertEqual(formatter.string(forTimeInterval: -10000), "2 ore fa")
        XCTAssertEqual(formatter.string(forTimeInterval: -100000), "1 g fa")
        XCTAssertEqual(formatter.string(forTimeInterval: -200000), "2 g fa")
        XCTAssertEqual(formatter.string(forTimeInterval: -10000000), "3 mesi fa")
    }

    func testStandardFuture() {
        XCTAssertEqual(formatter.string(forTimeInterval: 1), "1 secondo da adesso")
        XCTAssertEqual(formatter.string(forTimeInterval: 100), "1 minuto da adesso")
        XCTAssertEqual(formatter.string(forTimeInterval: 10000), "2 ore da adesso")
        XCTAssertEqual(formatter.string(forTimeInterval: 100000), "1 g da adesso")
        XCTAssertEqual(formatter.string(forTimeInterval: 200000), "2 g da adesso")
        XCTAssertEqual(formatter.string(forTimeInterval: 10000000), "3 mesi da adesso")
    }

    func testIdiomaticPast() {
        formatter.usesIdiomaticDeicticExpressions = true

        XCTAssertEqual(formatter.string(forTimeInterval: -1), "1 secondo fa")
        XCTAssertEqual(formatter.string(forTimeInterval: -100), "1 minuto fa")
        XCTAssertEqual(formatter.string(forTimeInterval: -10000), "2 ore fa")
        XCTAssertEqual(formatter.string(forTimeInterval: -100000), "ieri")
        XCTAssertEqual(formatter.string(forTimeInterval: -200000), "2 g fa")
        XCTAssertEqual(formatter.string(forTimeInterval: -10000000), "3 mesi fa")
    }
    
}
