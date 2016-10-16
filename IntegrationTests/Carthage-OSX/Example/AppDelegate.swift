//
//  AppDelegate.swift
//  Example
//
//  Created by Victor Ilyukevich on 5/21/16.
//  Copyright © 2016 Open Source. All rights reserved.
//

import Cocoa
import FormatterKit

@NSApplicationMain
class AppDelegate: NSObject, NSApplicationDelegate {

  @IBOutlet weak var window: NSWindow!

  func foo() -> String {
    let a = TTTTimeIntervalFormatter()
    return a.string(forTimeInterval: -3600)
  }

}

