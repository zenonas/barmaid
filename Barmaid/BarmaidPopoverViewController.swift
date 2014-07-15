//
//  BarmaidPopoverViewController.swift
//  Barmaid
//
//  Created by Zen Kyprianou on 15/07/2014.
//  Copyright (c) 2014 Zen Kyprianou. All rights reserved.
//

import Cocoa

class BarmaidPopoverViewController: NSViewController, NSTableViewDelegate, NSTableViewDataSource {

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
    
    func tableView(tableView: NSTableView!, viewForTableColumn tableColumn: NSTableColumn!, row: Int) -> NSView! {
        var service: Service = self.homebrew.services[row] as Service
        var cellView: NSTableCellView = tableView.makeViewWithIdentifier("ServiceCell", owner: self) as NSTableCellView
        cellView.textField.stringValue = service.name
        return cellView
    }
}
