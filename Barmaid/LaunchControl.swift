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
    
    func getPid() -> String {
        var pathComponents = self.path.componentsSeparatedByString("/")
        var serviceName = pathComponents[pathComponents.count - 1].stringByDeletingPathExtension
        
        var launchctlTask = NSTask()
        var grepTask = NSTask()
        var cutTask = NSTask()
        
        launchctlTask.launchPath = "/bin/launchctl"
        launchctlTask.arguments = ["list"]
        
        grepTask.launchPath = "/usr/bin/grep"
        grepTask.arguments = [serviceName]
        
        cutTask.launchPath = "/usr/bin/cut"
        cutTask.arguments = ["-f1"]
        
        var pipeLaunchCtlToGrep = NSPipe()
        launchctlTask.standardOutput = pipeLaunchCtlToGrep
        grepTask.standardInput = pipeLaunchCtlToGrep
        
        var pipeGrepToCut = NSPipe()
        grepTask.standardOutput = pipeGrepToCut
        cutTask.standardInput = pipeGrepToCut
        
        var pipeCutToFile = NSPipe()
        cutTask.standardOutput = pipeCutToFile
        
        var fileHandle: NSFileHandle = pipeCutToFile.fileHandleForReading as NSFileHandle
        
        launchctlTask.launch()
        grepTask.launch()
        cutTask.launch()
        
        var data = NSData()
        data = fileHandle.readDataToEndOfFile()
        var stringResult = NSString(data: data, encoding: NSUTF8StringEncoding) as String

        return stringResult
    }
}
