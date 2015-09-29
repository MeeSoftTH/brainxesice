//
//  StatViewController.swift
//  brainexecise
//
//  Created by Petch Temeeyasen on 5/29/15.
//  Copyright (c) 2015 meesoft. All rights reserved.
//

import WatchKit

class StatViewController: WKInterfaceController {
    
    @IBOutlet weak var rankLabel: WKInterfaceLabel!
    @IBOutlet weak var progressLabel: WKInterfaceLabel!
    @IBOutlet weak var todayLabel: WKInterfaceLabel!
    @IBOutlet weak var hiscoreLabel: WKInterfaceLabel!
    
    override func awakeWithContext(context: AnyObject?) {
        super.awakeWithContext(context)
        
        let userSetting: NSUserDefaults! = NSUserDefaults(suiteName: "group.brainexecise")
        
        var hiscore = userSetting.integerForKey("hiscore") as Int
        var todayScore = userSetting.integerForKey("todayscore") as Int
        var progress = userSetting.integerForKey("rankprogress") as Int
        var progressMax = userSetting.integerForKey("maxprogress") as Int
        var rank = userSetting.objectForKey("rank") as? String
        
        rankLabel.setText(rank)
        if rank == "Expert" {
            progressLabel.setText("∞")
        }
        else {
            progressLabel.setText(String(format: "%d / %d", progress, progressMax))
        }
        
        hiscoreLabel.setText(String(format: "%d", hiscore))
        
        if let lastDate = userSetting.objectForKey("lastdate") as? NSDate {
            let calender = NSCalendar.currentCalendar()
            if calender.isDateInToday(lastDate) {
                todayLabel.setText(String(format: "%d", todayScore))
            }
        }
        self.setTitle("Done")
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
