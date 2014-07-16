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
    let serviceId: String
    let launchctl: LaunchControl
    
    init(name: String, path: String) {
        self.name = name
        self.path = path
        var pathComponents = self.path.componentsSeparatedByString("/")
        self.serviceId = pathComponents[pathComponents.count - 1].stringByDeletingPathExtension
        self.launchctl = LaunchControl(serviceId: self.serviceId, path: self.path)
    }
    
    func start() {
        var status = self.status()
        switch status {
        case "stopped":
            self.launchctl.start()
        case "unloaded":
            self.launchctl.load()
        default:
            //Change this to an Error
            println("Service already running")
        }
    }
    
    func stop() {
        if self.status() == "running" {
            self.launchctl.stop()
        }
    }
    
    func restart() {
        self.stop()
        self.start()
    }
    
    func unload() {
        var status = self.status()
        switch status {
        case "stopped":
            self.launchctl.unload()
        case "running":
            self.launchctl.unload()
        default:
            //Change this to an Error
            println("Cannot unload a service that isn't loaded")
        }
    }
    
    func status() -> String {
        var pid = self.launchctl.getPid()
        switch pid {
        case "-":
            return "stopped"
        case "":
            return "unloaded"
        default:
            return "running"
        }
    }
}
