//
//  GlanceController.swift
//  brainexecise WatchKit Extension
//
//  Created by Petch Temeeyasen on 5/19/15.
//  Copyright (c) 2015 meesoft. All rights reserved.
//

import WatchKit

class GlanceController: WKInterfaceController {

    
    @IBOutlet weak var rankLabel: WKInterfaceLabel!
    @IBOutlet weak var todayScoreLabel: WKInterfaceLabel!
    @IBOutlet weak var stampLabel: WKInterfaceLabel!
    
    override func awakeWithContext(context: AnyObject?) {
        super.awakeWithContext(context)
        
        // Configure interface objects here.
        updateDailyScore()
    }

    override func willActivate() {
        // This method is called when watch view controller is about to be visible to user
        super.willActivate()
        updateDailyScore()
    }

    override func didDeactivate() {
        // This method is called when watch view controller is no longer visible
        super.didDeactivate()
    }
    
    func updateDailyScore(){
        let userSetting: NSUserDefaults! = NSUserDefaults(suiteName: "group.brainexecise")
        
        let todayScore = userSetting.integerForKey("todayscore") as Int
        if let lastDate = userSetting.objectForKey("lastdate") as? NSDate {
            //let now = NSDate()
            let calender = NSCalendar.currentCalendar()
            if calender.isDateInToday(lastDate) {
                todayScoreLabel.setText(String(format: " %d ", todayScore))
                let dateFormatter = NSDateFormatter()
                dateFormatter.dateFormat = "HH:mm"
                let str = dateFormatter.stringFromDate(lastDate)
                stampLabel.setText(String(format: " Update: %@", str))
            }
            else {
                todayScoreLabel.setText(" ? ")
                stampLabel.setText(" Test Now!!")
            }
        }
    
        let rank = userSetting.objectForKey("rank") as? String
        rankLabel.setText(String(format: " %@", rank!))
    }
}
