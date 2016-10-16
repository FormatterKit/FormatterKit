//
//  TTTTimeIntervalFormatterTests.swift
//  FormatterKit Example
//
//  Created by Victor Ilyukevich on 10/15/16.
//
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
        XCTAssertEqual(formatter.string(forTimeInterval: -1), "преди 1 секунда")
        XCTAssertEqual(formatter.string(forTimeInterval: -100), "преди 1 минута")
        XCTAssertEqual(formatter.string(forTimeInterval: -10000), "преди 2 часа")
        XCTAssertEqual(formatter.string(forTimeInterval: -100000), "преди 1 ден")
        XCTAssertEqual(formatter.string(forTimeInterval: -200000), "преди 2 дни")
        XCTAssertEqual(formatter.string(forTimeInterval: -10000000), "преди 3 месеци")
    }

    func testStandardFuture() {
        XCTAssertEqual(formatter.string(forTimeInterval: 1), "след 1 секунда")
        XCTAssertEqual(formatter.string(forTimeInterval: 100), "след 1 минута")
        XCTAssertEqual(formatter.string(forTimeInterval: 10000), "след 2 часа")
        XCTAssertEqual(formatter.string(forTimeInterval: 100000), "след 1 ден")
        XCTAssertEqual(formatter.string(forTimeInterval: 200000), "след 2 дни")
        XCTAssertEqual(formatter.string(forTimeInterval: 10000000), "след 3 месеци")
    }

    func testIdiomaticPast() {
        formatter.usesIdiomaticDeicticExpressions = true

        XCTAssertEqual(formatter.string(forTimeInterval: -1), "преди 1 секунда")
        XCTAssertEqual(formatter.string(forTimeInterval: -100), "преди 1 минута")
        XCTAssertEqual(formatter.string(forTimeInterval: -10000), "преди 2 часа")
        XCTAssertEqual(formatter.string(forTimeInterval: -100000), "преди 1 ден")
        XCTAssertEqual(formatter.string(forTimeInterval: -200000), "преди 2 дни")
        XCTAssertEqual(formatter.string(forTimeInterval: -10000000), "преди 3 месеци")
    }

}
