//
//  BeginnerProgressViewController.swift
//  brainexecise
//
//  Created by Petch Temeeyasen on 5/19/15.
//  Copyright (c) 2015 meesoft. All rights reserved.
//

import WatchKit

class BeginnerProgressViewController: WKInterfaceController {
    
    @IBOutlet weak var badge1: WKInterfaceImage!
    @IBOutlet weak var badge2: WKInterfaceImage!
    @IBOutlet weak var badge3: WKInterfaceImage!
    
    override func awakeWithContext(context: AnyObject?) {
        super.awakeWithContext(context)
        
        let userSetting: NSUserDefaults! = NSUserDefaults(suiteName: "group.brainexecise")
        
        let progress = userSetting.integerForKey("rankprogress") as Int
        let level = userSetting.integerForKey("level") as Int
        if progress >= 1 || level == 2 {
            badge1.setAlpha(1.0)
        }
        if progress >= 2 || level == 2 {
            badge2.setAlpha(1.0)
        }
        if progress > 2 || level == 2 {
            badge3.setAlpha(1.0)
        }
    }
    
    override func willActivate() {
        // This method is called when watch view controller is about to be visible to user
        super.willActivate()
    }
    
    override func didDeactivate() {
        // This method is called when watch view controller is no longer visible
        super.didDeactivate()
    }
}
