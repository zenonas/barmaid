//
//  BarmaidPopoverViewController.swift
//  Barmaid
//
//  Created by Zen Kyprianou on 15/07/2014.
//  Copyright (c) 2014 Zen Kyprianou. All rights reserved.
//

import Cocoa

class BarmaidPopoverViewController: NSViewController, NSTableViewDelegate, NSTableViewDataSource {

    @IBOutlet var tableView: NSTableView
    @IBOutlet var startButton: NSButton
    @IBOutlet var restartButton: NSButton
    var homebrew: Homebrew = Homebrew()

    override func awakeFromNib() {
        
    }
    
    override func viewDidAppear() {

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
        if sender.identifier == "start" {
            if service.status() == "stopped" {
                service.start()
                sender.identifier = "stop"
                sender.image = NSImage(named: NSImageNameStopProgressTemplate)
            }
        }
        else if sender.identifier == "stop" {
            if service.status() == "running" {
                service.stop()
                sender.identifier = "start"
                sender.image = NSImage(named: NSImageNameRightFacingTriangleTemplate)
            }
            
        }
        self.tableView.reloadData()
    }
    
    @IBAction func restartButtonPress(sender: NSTableView) {
        var row = self.tableView.rowForView(sender)
        var service: Service = self.homebrew.services.objectAtIndex(row) as Service
        service.restart()
    }
    
    func tableView(tableView: NSTableView!, viewForTableColumn tableColumn: NSTableColumn!, row: Int) -> NSView! {
        var service: Service = self.homebrew.services[row] as Service
        var cellView: NSTableCellView = tableView.makeViewWithIdentifier("ServiceCell", owner: self) as NSTableCellView
        cellView.textField.stringValue = service.name
        if service.status() == "running" {
            cellView.imageView.image = NSImage(named:NSImageNameStatusAvailable)
        } else {
            cellView.imageView.image = NSImage(named: NSImageNameStatusUnavailable)
        }
        return cellView
    }

}
