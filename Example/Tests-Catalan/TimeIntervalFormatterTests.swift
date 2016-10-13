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
        XCTAssertEqual(formatter.string(forTimeInterval: -1), "fa 1 segon")
        XCTAssertEqual(formatter.string(forTimeInterval: -100), "fa 1 minut")
        XCTAssertEqual(formatter.string(forTimeInterval: -10000), "fa 2 hores")
        XCTAssertEqual(formatter.string(forTimeInterval: -100000), "fa 1 dia")
        XCTAssertEqual(formatter.string(forTimeInterval: -200000), "fa 2 dies")
        XCTAssertEqual(formatter.string(forTimeInterval: -10000000), "fa 3 mesos")
    }

    func testStandardFuture() {
        XCTAssertEqual(formatter.string(forTimeInterval: 1), "d\'aquí 1 segon")
        XCTAssertEqual(formatter.string(forTimeInterval: 100), "d\'aquí 1 minut")
        XCTAssertEqual(formatter.string(forTimeInterval: 10000), "d\'aquí 2 hores")
        XCTAssertEqual(formatter.string(forTimeInterval: 100000), "d\'aquí 1 dia")
        XCTAssertEqual(formatter.string(forTimeInterval: 200000), "d\'aquí 2 dies")
        XCTAssertEqual(formatter.string(forTimeInterval: 10000000), "d\'aquí 3 mesos")
    }

    func testIdiomaticPast() {
        formatter.usesIdiomaticDeicticExpressions = true

        XCTAssertEqual(formatter.string(forTimeInterval: -1), "fa 1 segon")
        XCTAssertEqual(formatter.string(forTimeInterval: -100), "fa 1 minut")
        XCTAssertEqual(formatter.string(forTimeInterval: -10000), "fa 2 hores")
        XCTAssertEqual(formatter.string(forTimeInterval: -100000), "ahir")
        XCTAssertEqual(formatter.string(forTimeInterval: -200000), "abans d\'ahir")
        XCTAssertEqual(formatter.string(forTimeInterval: -10000000), "fa 3 mesos")
    }
    
}
