//
//  BrewServices.swift
//  Barmaid
//
//  Created by Zen Kyprianou on 14/07/2014.
//  Copyright (c) 2014 Zen Kyprianou. All rights reserved.
//

import Cocoa

class Homebrew {
    
    var task: NSTask!
    var pipe: NSPipe!
    var file: NSFileHandle!
    var services: NSMutableArray!
    
    init() {
        self.findServices()
    }
    
    func findServices() {
        self.services = NSMutableArray()
        self.task = NSTask()
        self.task.launchPath = "/bin/bash"
        self.pipe = NSPipe()
        self.file = NSFileHandle()
        self.task.standardOutput = self.pipe
        self.file = self.pipe.fileHandleForReading
        self.task.arguments = ["-c", "/usr/bin/find -L /usr/local/opt -type f -name 'homebrew*.plist'"]
        self.task.launch()
        self.task.waitUntilExit()
        
        var data = NSData()
        data = self.file.readDataToEndOfFile()
        
        var stringResult = NSString(data: data, encoding: NSUTF8StringEncoding) as String
        var allPaths = stringResult.componentsSeparatedByString("\n")
        
        for service in allPaths {
            if (service != "") {
                var key = service.componentsSeparatedByString("/")[4].capitalizedString
                var newService = Service(name: key, path: service)
                self.services.addObject(newService)
            }
        }
    }
}