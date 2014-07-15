//
//  LaunchControl.swift
//  Barmaid
//
//  Created by Zen Kyprianou on 14/07/2014.
//  Copyright (c) 2014 Zen Kyprianou. All rights reserved.
//

import Cocoa

class LaunchControl {

    var services: Dictionary<String, String>
    var launchctl: NSTask
    
    init(brew: Homebrew) {
        self.services = Dictionary<String, String>()
        self.launchctl = NSTask()
        self.launchctl.launchPath = "/bin/launchctl"
    }
    
    func load(services: Dictionary<String, String>) {
        for (serviceName, serviceLocation) in services {
            self.launchctl.arguments = ["load", serviceLocation]
            self.launchctl.launch()
            self.launchctl.waitUntilExit()
        }
    }
    
}
