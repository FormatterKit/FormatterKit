//
//  AppDeletage.swift
//  FormatterKit Example
//
//  Created by Victor Ilyukevich on 2/7/16.
//  Copyright © 2016. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDeletage: UIResponder {
    var window: UIWindow?
    var navigationController: UINavigationController?
}

extension AppDeletage: UIApplicationDelegate {
    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject : AnyObject]?) -> Bool {
        window = UIWindow(frame: UIScreen.mainScreen().bounds)
        window!.backgroundColor = UIColor.whiteColor()

        let viewController = RootViewController()
        navigationController = UINavigationController(rootViewController: viewController)
        window!.addSubview((navigationController!.view)!)
        window!.rootViewController = navigationController
        window!.makeKeyAndVisible()

        return true
    }
}
