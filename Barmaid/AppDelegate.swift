//
//  AppDelegate.swift
//  Barmaid
//
//  Created by Zen Kyprianou on 14/07/2014.
//  Copyright (c) 2014 Zen Kyprianou. All rights reserved.
//

import Cocoa
import AppKit

class AppDelegate: NSObject, NSApplicationDelegate {
                            
    @IBOutlet var barmaidMenu: NSMenu
    var barmaidMenuItem: NSStatusItem?
    

    func applicationDidFinishLaunching(aNotification: NSNotification?) {

        // Insert code here to initialize your application
    }

    func applicationWillTerminate(aNotification: NSNotification?) {
        // Insert code here to tear down your application
    }
    
    override func awakeFromNib() {
        var statusBar = NSStatusBar.systemStatusBar()
        //Change -1 to CGFloat(NSVariableStatusItemLength) this is a Xcode 6 Beta 3 bug
        barmaidMenuItem = statusBar.statusItemWithLength(-1)
        barmaidMenuItem!.menu = barmaidMenu
        barmaidMenuItem!.image = NSImage(named: "beer_mug")
        barmaidMenuItem!.title = "Barmaid"
    }


}

