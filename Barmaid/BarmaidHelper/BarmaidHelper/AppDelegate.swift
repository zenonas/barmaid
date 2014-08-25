//
//  AppDelegate.swift
//  BarmaidHelper
//
//  Created by Zen Kyprianou on 25/08/2014.
//  Copyright (c) 2014 Zen Kyprianou. All rights reserved.
//

import Cocoa

class barmaidHelperAppDelegate: NSObject, NSApplicationDelegate {
    
    let barmaidMainAppIdentifier:String = "com.zenonas.Barmaid"
    let barmaidName: String = "Barmaid"
    func applicationDidFinishLaunching(aNotification: NSNotification?) {
        var alreadyRunning = false
        var runningApplications = NSWorkspace.sharedWorkspace().runningApplications as Array
        for app in runningApplications {
            println(app.bundleIdentifier)
            if (app.bundleIdentifier == barmaidMainAppIdentifier) {
                alreadyRunning = true
            }
        }
        if (!alreadyRunning) {
            var path = NSBundle.mainBundle().bundlePath
            var pathComponents: Array = path.pathComponents as Array
            pathComponents.removeLast()
            pathComponents.removeLast()
            pathComponents.removeLast()
            pathComponents.append("MacOS")
            pathComponents.append(self.barmaidName)
            var mainAppPath: NSString = NSString.pathWithComponents(pathComponents)
            NSWorkspace.sharedWorkspace().launchApplication(mainAppPath)
        }
        NSApplication.sharedApplication().terminate(self)
    }

    func applicationWillTerminate(aNotification: NSNotification?) {
        // Insert code here to tear down your application
    }


}

