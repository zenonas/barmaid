//
//  Barmaid.swift
//  Barmaid
//
//  Created by Zen Kyprianou on 14/07/2014.
//  Copyright (c) 2014 Zen Kyprianou. All rights reserved.
//

import Cocoa
import Foundation

class BarmaidView: NSView {

    var logo: NSImage
    let statusItem: NSStatusItem
    
    var onMouseDown: () -> ()
    
    var isSelected: Bool {
        didSet {
            if (isSelected != oldValue) {
                self.needsDisplay = true
            }
        }
    }
    
    init(logo: String, statusItem: NSStatusItem) {
        self.logo = NSImage(named: logo)!
        self.statusItem = statusItem
        self.isSelected = false
        self.onMouseDown = {}
        
        let thickness = NSStatusBar.systemStatusBar().thickness
        let rect = CGRectMake(0,0, thickness, thickness)

        super.init(frame: rect)
    }

    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func drawRect(rect: NSRect) {
        self.statusItem.drawStatusBarBackgroundInRect(rect, withHighlight: self.isSelected)
        
        let size = self.logo.size
        let rect = CGRectMake(3,3, size.width, size.height)
        
        self.logo.drawInRect(rect)
    }
    
    override func mouseDown(theEvent: NSEvent) {
        self.isSelected = !self.isSelected
        self.onMouseDown()
    }
    
}