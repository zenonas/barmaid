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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do view setup here.
    }
    
    func numberOfRowsInTableView(tableView: NSTableView!) -> Int {
        return self.homebrew.services.count
    }
    
    @IBAction func startButtonPress(sender: NSButton) {
        var row = self.tableView.rowForView(sender)
        var service: Service = self.homebrew.services.objectAtIndex(row) as Service
        service.start()
    }
    
    @IBAction func restartButtonPress(sender: NSTableView) {
        var row = self.tableView.rowForView(sender)
        var service: Service = self.homebrew.services.objectAtIndex(row) as Service
        service.stop()
        service.start()
    }
    
    func tableView(tableView: NSTableView!, viewForTableColumn tableColumn: NSTableColumn!, row: Int) -> NSView! {
        var service: Service = self.homebrew.services[row] as Service
        var cellView: NSTableCellView = tableView.makeViewWithIdentifier("ServiceCell", owner: self) as NSTableCellView
        cellView.textField.stringValue = service.name
        //var startButton: NSButton = tableView.makeViewWithIdentifier("startButton", owner: self) as NSButton
        //startButton.stringValue = "Hello"
        return cellView
    }
}
