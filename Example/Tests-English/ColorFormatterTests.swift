//
//  ColorFormatterTests.swift
//  FormatterKit Example
//
//  Created by Victor Ilyukevich on 5/14/16.
//  Copyright © 2016. All rights reserved.
//

import XCTest
import FormatterKit

class ColorFormatterTests: XCTestCase {

    var formatter: TTTColorFormatter!

    override func setUp() {
        super.setUp()
        formatter = TTTColorFormatter()
    }

    // MARK: Tests

    func testHexadecimal() {
        XCTAssertEqual(formatter.hexadecimalString(from: UIColor.white), "#FFFFFF")
        XCTAssertEqual(formatter.hexadecimalString(from: UIColor.black), "#000000")

        let orange = formatter.color(fromHexadecimalString: "#FF8000")
        XCTAssertEqual(formatter.color(fromHexadecimalString: "#ff8000"), orange)
        XCTAssertEqual(formatter.hexadecimalString(from: orange), "#FF8000")
    }

    func testColorFromHexadecimalWithoutPound() {
        XCTAssertEqual(formatter.color(fromHexadecimalString: "FF8000"), formatter.color(fromHexadecimalString: "#FF8000"))
    }

    func testRGB() {
        XCTAssertEqual(formatter.rgbString(from: UIColor.white), "rgb(255, 255, 255)")
        XCTAssertEqual(formatter.rgbString(from: UIColor.black), "rgb(0, 0, 0)")

        let color = UIColor.red
        let colorString = formatter.rgbString(from: color)
        XCTAssertEqual(formatter.color(fromRGBString: colorString), color)
    }

    func testRGBA() {
        XCTAssertEqual(formatter.rgbaString(from: UIColor.white), "rgb(255, 255, 255, 1)")
        XCTAssertEqual(formatter.rgbaString(from: UIColor.black.withAlphaComponent(0.42)), "rgb(0, 0, 0, 0.42)")

        let color = UIColor.red
        let colorString = formatter.rgbaString(from: color)
        XCTAssertEqual(formatter.color(fromRGBAString: colorString), color)
    }

    func testCMYK() {
        XCTAssertEqual(formatter.cmykString(from: UIColor.white), "cmyk(0%, 0%, 0%, 0%)")
        // TODO: probably a bug. returns `nan%`
        // XCTAssertEqual(formatter.CMYKStringFromColor(UIColor.blackColor()), "cmyk(0%, 0%, 0%, 100%)")

        let color = UIColor.orange
        let colorString = formatter.cmykString(from: color)
        XCTAssertEqual(formatter.color(fromCMYKString: colorString), color)
    }

    func testHSL() {
        XCTAssertEqual(formatter.hslString(from: UIColor.white), "hsl(, 0%, 100%)")
        XCTAssertEqual(formatter.hslString(from: UIColor.black), "hsl(, 0%, 0%)")
        XCTAssertEqual(formatter.hslString(from: UIColor.red), "hsl(255, 100%, 50%)")

        // TODO: there must be a bug
        // let colorString = "hsl(255, 100%, 50%)"
        // let color = formatter.colorFromHSLString(colorString)
        // XCTAssertEqual(formatter.HSLStringFromColor(color), colorString)
    }

    func testUIColorDeclaration() {
        let color = UIColor(red: 0, green: 1, blue: 0.2, alpha: 0.31)
        XCTAssertEqual(formatter.uiColorDeclaration(from: color), "[UIColor colorWithRed:0 green:1 blue:0.2 alpha:0.31]")
    }
}
