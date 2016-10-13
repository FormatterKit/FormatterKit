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

    let dogCatParrot = ["Dog", "Cat", "Parrot"]

    override func setUp() {
        super.setUp()
        formatter = TTTArrayFormatter()
    }

    // MARK: Tests

    func testDefault() {
        let result = formatter.string(from: dogCatParrot)
        let expected = "Dog, Cat, and Parrot"
        
        XCTAssertEqual(result, expected)
        // TODO
        // XCTAssertEqual(formatter.arrayFromString(expected) as! [String], dogCatParrot)
    }

    func testAbbreviatedConjunction() {
        formatter.usesAbbreviatedConjunction = true

        let result = formatter.string(from: dogCatParrot)
        let expected = "Dog, Cat, & Parrot"

        XCTAssertEqual(result, expected)
        // TODO
        // XCTAssertEqual(formatter.arrayFromString(expected) as! [String], dogCatParrot)

    }

    func testWithoutOxformComma() {
        formatter.usesSerialDelimiter = false

        let result = formatter.string(from: dogCatParrot)
        let expected = "Dog, Cat and Parrot"

        XCTAssertEqual(result, expected)
        // TODO
        // XCTAssertEqual(formatter.arrayFromString(expected) as! [String], dogCatParrot)
    }

}
