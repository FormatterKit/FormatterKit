//
//  ArrayFormatterTests.swift
//  FormatterKit Example
//
//  Created by Victor Ilyukevich on 5/14/16.
//  Copyright © 2016. All rights reserved.
//

import XCTest
import FormatterKit

class ArrayFormatterTests: XCTestCase {

    var formatter: TTTArrayFormatter!

    let dogCatParrot = ["狗", "猫", "鹦鹉"]

    override func setUp() {
        super.setUp()
        formatter = TTTArrayFormatter()
    }

    // MARK: Tests

    func testDefault() {
        let result = formatter.string(from: dogCatParrot)
        let expected = "狗、猫、及鹦鹉"

        XCTAssertEqual(result, expected)
        // TODO
        // XCTAssertEqual(formatter.arrayFromString(expected) as! [String], dogCatParrot)
    }

    func testAbbreviatedConjunction() {
        formatter.usesAbbreviatedConjunction = true

        let result = formatter.string(from: dogCatParrot)
        let expected = "狗、猫、和鹦鹉"

        XCTAssertEqual(result, expected)
        // TODO
        // XCTAssertEqual(formatter.arrayFromString(expected) as! [String], dogCatParrot)
    }
}
