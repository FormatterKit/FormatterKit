//
//  AppDelegate.swift
//  Example
//
//  Created by Victor Ilyukevich on 4/22/16.
//  Copyright © 2016 Open Source. All rights reserved.
//

import UIKit
import FormatterKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

  var window: UIWindow?

  func foo() -> String {
    let intervalFormatter = TTTTimeIntervalFormatter()
    return intervalFormatter.string(forTimeInterval: -3600*24*7*3)
  }
}

