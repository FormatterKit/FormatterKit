//
//  ExampleTests.swift
//  ExampleTests
//
//  Created by Victor Ilyukevich on 5/21/16.
//  Copyright © 2016 Open Source. All rights reserved.
//

import XCTest
@testable import Example

class ExampleTests: XCTestCase {
  func testFoo() {
    let a = AppDelegate()
    XCTAssertEqual(a.foo(), "hace 3 semanas")
  }
}
