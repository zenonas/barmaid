//
//  BarmaidPopoverViewController.swift
//  Barmaid
//
//  Created by Zen Kyprianou on 15/07/2014.
//  Copyright (c) 2014 Zen Kyprianou. All rights reserved.
//

import Cocoa

class BarmaidPopoverViewController: NSViewController, NSTableViewDelegate, NSTableViewDataSource {

    @IBOutlet var tableView: NSTableView!
    @IBOutlet weak var cogwheelMenu: NSMenu!
    @IBOutlet weak var startAtLoginToggle: NSMenuItem!
    
    let startImage: NSImage = NSImage(named: NSImageNameRightFacingTriangleTemplate)
    let stopImage: NSImage = NSImage(named: NSImageNameStopProgressTemplate)
    
    var homebrew: Homebrew = Homebrew()
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
    }

    // Cogwheelfunctions
    
    @IBAction func startAtLoginPress(sender: AnyObject) {
        
    }

    @IBAction func cogwheelMenuPress(sender: AnyObject) {
        NSMenu.popUpContextMenu(cogwheelMenu, withEvent: NSApplication.sharedApplication().currentEvent, forView: sender as NSButton)
    }
    
    @IBAction func reloadMenuItemPress(sender: AnyObject) {
        self.homebrew.findServices()
        self.tableView.reloadData()
    }
    
    @IBAction func barmaidAboutButton(sender: AnyObject) {
        NSApp.orderFrontStandardAboutPanel(sender)
    }
    
    @IBAction func quitMenuItemPress(sender: AnyObject) {
        NSApplication.sharedApplication().terminate(self)
    }

    // Table View related functions
    func startStopButtonPress(sender: NSButton) {
        var row = self.tableView.rowForView(sender)
        var service: Service = self.homebrew.services.objectAtIndex(row) as Service
        var status: String = service.status() as String
        if sender.image == self.startImage && (status == "stopped" || status == "unloaded") {
            service.start()
        }
        else if sender.image == self.stopImage && status == "running" {
            service.unload()
        }
        self.tableView.reloadData()
    }
    
    func popoverWillShow() {
        println("will show")
    }
    
    func numberOfRowsInTableView(tableView: NSTableView!) -> Int {
        return self.homebrew.services.count
    }
    
    func tableView(tableView: NSTableView!, viewForTableColumn tableColumn: NSTableColumn!, row: Int) -> NSView! {
        var service: Service = self.homebrew.services[row] as Service
        var cellView: NSTableCellView = tableView.makeViewWithIdentifier("ServiceCell", owner: self) as NSTableCellView
        
        var buttonRect: NSRect = NSRect(x: 145, y: 1, width: 21,height: 21)
        var button:NSButton! = cellView.viewWithTag(0011) as NSButton!
        
        if (button == nil) {
            button = NSButton(frame: buttonRect)
            button.tag = 0011
            button.bordered = false
            button.target = self
            button.action = "startStopButtonPress:"
            cellView.addSubview(button)
        }
        
        cellView.textField.stringValue = service.name
        
        if service.status() == "running" {
            cellView.imageView.image = NSImage(named:NSImageNameStatusAvailable)
            button.image = self.stopImage
        } else {
            cellView.imageView.image = NSImage(named: NSImageNameStatusUnavailable)
            button.image = self.startImage
        }
        return cellView
    }

}
