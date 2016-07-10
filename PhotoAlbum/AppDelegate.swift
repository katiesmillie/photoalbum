//
//  AppDelegate.swift
//  PhotoAlbum
//
//  Created by Katie Smillie on 7/7/16.
//  Copyright © 2016 Katie Smillie. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        let window = self.window ?? UIWindow(frame: UIScreen.mainScreen().bounds)
        let root = RootViewController()
        window.rootViewController = root
        window.makeKeyAndVisible()
        self.window = window

        return true
    }

  
}

