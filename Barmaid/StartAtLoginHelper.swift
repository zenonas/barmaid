//
//  StartAtLoginHelper.swift
//  Barmaid
//
//  Created by Zen Kyprianou on 25/08/2014.
//  Copyright (c) 2014 Zen Kyprianou. All rights reserved.
//

import Cocoa
import ServiceManagement

class StartAtLoginHelper {

    let userDefaults: NSUserDefaults
    var startAtLogin: Bool
    var errorInfo: AutoreleasingUnsafeMutablePointer<NSDictionary?>
    
    init() {
        userDefaults = NSUserDefaults.standardUserDefaults()
        startAtLogin = userDefaults.boolForKey("startAtLogin")
        errorInfo = AutoreleasingUnsafeMutablePointer<NSDictionary?>()
    }
    
    func toggleStartAtLogin() {
        if (startAtLogin) {
            disableStartAtLogin()
            startAtLogin = false
        } else {
            enableStartAtLogin()
            startAtLogin = true
        }
        updateDefaults()
    }
    
    func updateDefaults() {
        userDefaults.setBool(startAtLogin, forKey: "startAtLogin")
        userDefaults.synchronize()
    }

    func enableStartAtLogin() {
        var tell: String = "tell application \"System Events\"\n"
        var getProperties: String = "get the properties of every login item\n"
        var newItem: String = "make new login item at the end of login items with properties {path: \"/Applications/Barmaid.app\", hidden: false}\n"
        var endTell: String = "end tell"
        var startAtLoginScript: NSAppleScript = NSAppleScript(source: tell + getProperties + newItem + endTell)

        startAtLoginScript.executeAndReturnError(errorInfo)
    }
    
    func disableStartAtLogin() {
        var tell: String = "tell application \"System Events\"\n"
        var deleteItem: String = "if login item \"Barmaid\" exists then delete login item \"Barmaid\"\n"
        var endTell: String = "end tell"
        var startAtLoginScript: NSAppleScript = NSAppleScript(source: tell + deleteItem + endTell)

        startAtLoginScript.executeAndReturnError(errorInfo)
        
    }
    
    
}
