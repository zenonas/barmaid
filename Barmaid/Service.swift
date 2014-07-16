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
    
    init(name: String, path: String) {
        self.name = name
        self.path = path
        self.launchctl = LaunchControl(path: self.path)
    }
    
    func start() {
        if self.status() == "stopped" {
            self.launchctl.load()
        }
    }
    
    func stop() {
        if self.status() == "running" {
            self.launchctl.unload()
        }
    }
    
    func status() -> String {
        var pid = self.launchctl.getPid()
        if (pid == "\n" || pid == "-\n") {
            println(pid)
            return "stopped"
        } else {
            println(pid)
            return "running"
        }
    }
}
