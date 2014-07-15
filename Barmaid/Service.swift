//
//  Service.swift
//  Barmaid
//
//  Created by Zen Kyprianou on 15/07/2014.
//  Copyright (c) 2014 Zen Kyprianou. All rights reserved.
//

import Cocoa

class Service {

    let name: String
    let path: String
    let launchctl: LaunchControl
    var status: String
    
    init(name: String, path: String) {
        self.name = name
        self.path = path
        self.status = "stopped"
        self.launchctl = LaunchControl(path: self.path)
    }
    
    func start() {
        if status == "stopped" {
            self.launchctl.load()
            self.status = "running"
        }
    }
    
    func stop() {
        if status == "running" {
            self.launchctl.unload()
            self.status = "stopped"
        }
    }
}
