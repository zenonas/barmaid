//
//  LaunchControl.swift
//  Barmaid
//
//  Created by Zen Kyprianou on 14/07/2014.
//  Copyright (c) 2014 Zen Kyprianou. All rights reserved.
//

import Cocoa

class LaunchControl {
    
    let path: String
    let launchPath: String
    
    init(path: String) {
        self.path = path
        self.launchPath = "/bin/launchctl"
    }
    
    func load() {
        var arguments = ["load", self.path]
        NSTask.launchedTaskWithLaunchPath(self.launchPath, arguments: arguments)
    }
    
    func unload() {
        var arguments = ["unload", self.path]
        NSTask.launchedTaskWithLaunchPath(self.launchPath, arguments: arguments)
    }
}
