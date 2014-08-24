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
    
    let startImage: NSImage = NSImage(named: NSImageNameRightFacingTriangleTemplate)
    let stopImage: NSImage = NSImage(named: NSImageNameStopProgressTemplate)
    
    var homebrew: Homebrew = Homebrew()

    override func awakeFromNib() {
        
    }
    
    override func viewDidAppear() {
        self.tableView.reloadData()
    }
    
    override func viewWillAppear() {
        self.tableView.reloadData()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do view setup here.
    }
    
    func numberOfRowsInTableView(tableView: NSTableView!) -> Int {
        return self.homebrew.services.count
    }
    
    @IBAction func barmaidAboutButon(sender: NSTextField) {
        NSApp.orderFrontStandardAboutPanel(sender)
    }
    
    @IBAction func startStopButtonPress(sender: NSButton) {
        var row = self.tableView.rowForView(sender)
        var service: Service = self.homebrew.services.objectAtIndex(row) as Service
        var status: String = service.status() as String
        if sender.image == self.startImage && (status == "stopped" || status == "unloaded") {
            println("hello")
            service.start()
            sender.image = self.startImage
        }
        else if sender.image == self.stopImage && status == "running" {
            service.stop()
            sender.image = self.stopImage
        }
        self.tableView.reloadData()
    }
    
    func tableView(tableView: NSTableView!, viewForTableColumn tableColumn: NSTableColumn!, row: Int) -> NSView! {
        var service: Service = self.homebrew.services[row] as Service
        var cellView: NSTableCellView = tableView.makeViewWithIdentifier("ServiceCell", owner: self) as NSTableCellView
        
        var buttonRect: NSRect = NSRect(x: 143, y: 1, width: 21,height: 21)
        var button:NSButton = NSButton(frame: buttonRect)
        button.bordered = false
        
        cellView.addSubview(button)
        
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
