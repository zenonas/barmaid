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

    let barmaidHelper: NSString = "com.zenonas.BarmaidHelper"
    let userDefaults: NSUserDefaults
    var startAtLogin: Bool
    
    init() {
        userDefaults = NSUserDefaults.standardUserDefaults()
        startAtLogin = userDefaults.boolForKey("startAtLogin")
    }
    
    func error() {
        // Switch to an NSAlert box
        println("Could not switch the start at login")
    }
    
    func toggleStartAtLogin() {
        if (startAtLogin) {
            var status: Boolean = SMLoginItemSetEnabled(barmaidHelper, 0)
            println(status)
            if (SMLoginItemSetEnabled(barmaidHelper, 0) == 1) {
                userDefaults.setBool(false, forKey: "startAtLogin")
                startAtLogin = false
            } else {
                error()
            }
        } else {
            if (SMLoginItemSetEnabled(barmaidHelper, 1) == 1) {
                userDefaults.setBool(true, forKey: "startAtLogin")
                startAtLogin = true
            } else {
                error()
            }
        }
    }
    
    
    
}
