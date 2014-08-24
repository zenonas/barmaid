//
//  AppDelegate.swift
//  Barmaid
//
//  Created by Zen Kyprianou on 14/07/2014.
//  Copyright (c) 2014 Zen Kyprianou. All rights reserved.
//

import Cocoa

class AppDelegate: NSObject, NSApplicationDelegate {
    
    @IBOutlet var barmaidPopover: NSPopover!

    let barmaid: BarmaidView
    
    override init() {
        let statusBar = NSStatusBar.systemStatusBar()
        
        //Change -1 to CGFloat(NSVariableStatusItemLength) this is a Xcode 6 Beta 3 bug
        let barmaidItem = statusBar.statusItemWithLength(-1)
        
        self.barmaid = BarmaidView(logo: "beer_mug_16", statusItem: barmaidItem)
        barmaidItem.view = barmaid
        super.init()
    }
    
    func applicationDidFinishLaunching(aNotification: NSNotification?) {
        // Insert code here to initialize your application
    }

    func applicationWillTerminate(aNotification: NSNotification?) {
        // Kill services
        // Insert code here to tear down your application
    }
    
    override func awakeFromNib() {
        let edge = 1
        let barmaid = self.barmaid
        let rect = barmaid.frame
        
        barmaid.onMouseDown = {
            if (barmaid.isSelected) {
                self.barmaidPopover.showRelativeToRect(rect, ofView: barmaid, preferredEdge: edge)
                return
            }
            self.barmaidPopover.close()
        }
    }


}

