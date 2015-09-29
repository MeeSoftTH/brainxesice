//
//  ProProgressViewController.swift
//  brainexecise
//
//  Created by Petch Temeeyasen on 5/19/15.
//  Copyright (c) 2015 meesoft. All rights reserved.
//

import WatchKit

class ProProgressViewController: WKInterfaceController {
    
    @IBOutlet weak var badge1: WKInterfaceImage!
    @IBOutlet weak var badge2: WKInterfaceImage!
    @IBOutlet weak var badge3: WKInterfaceImage!
    @IBOutlet weak var badge4: WKInterfaceImage!
    @IBOutlet weak var badge5: WKInterfaceImage!
    @IBOutlet weak var badge6: WKInterfaceImage!
    @IBOutlet weak var badge7: WKInterfaceImage!
    @IBOutlet weak var badge8: WKInterfaceImage!
    
    override func awakeWithContext(context: AnyObject?) {
        super.awakeWithContext(context)
        
        let userSetting: NSUserDefaults! = NSUserDefaults(suiteName: "group.brainexecise")
        
        let progress = userSetting.integerForKey("rankprogress") as Int
        let level = userSetting.integerForKey("level") as Int
        if progress >= 1 || level == 3 {
            badge1.setAlpha(1.0)
        }
        if progress >= 2 || level == 3 {
            badge2.setAlpha(1.0)
        }
        if progress >= 3 || level == 3 {
            badge3.setAlpha(1.0)
        }
        if progress >= 4 || level == 3 {
            badge4.setAlpha(1.0)
        }
        if progress >= 5 || level == 3 {
            badge5.setAlpha(1.0)
        }
        if progress >= 6 || level == 3 {
            badge6.setAlpha(1.0)
        }
        if progress >= 7 || level == 3 {
            badge7.setAlpha(1.0)
        }
        if progress >= 8 || level == 3 {
            badge8.setAlpha(1.0)
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
