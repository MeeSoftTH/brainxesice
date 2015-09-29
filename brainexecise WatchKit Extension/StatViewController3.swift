//
//  StatViewController3.swift
//  brainexecise
//
//  Created by Petch Temeeyasen on 6/4/15.
//  Copyright (c) 2015 meesoft. All rights reserved.
//

import WatchKit

class StatViewController3 : WKInterfaceController {

    @IBOutlet weak var allTimeLabel: WKInterfaceLabel!
    @IBOutlet weak var dailyLabel: WKInterfaceLabel!
    @IBOutlet weak var speedCalLabel: WKInterfaceLabel!
    @IBOutlet weak var trueFalseLabel: WKInterfaceLabel!
    @IBOutlet weak var operatorLabel: WKInterfaceLabel!
    
    override func awakeWithContext(context: AnyObject?) {
        super.awakeWithContext(context)
        
        let userSetting: NSUserDefaults! = NSUserDefaults(suiteName: "group.brainexecise")
        let all = userSetting.integerForKey("totalplay") as Int
        let daily = userSetting.integerForKey("dailyplay") as Int
        
        let game1 = userSetting.integerForKey("game1play") as Int
        let game2 = userSetting.integerForKey("game2play") as Int
        let game3 = userSetting.integerForKey("game3play") as Int
        
        allTimeLabel.setText(String(format: "%d", all))
        
        dailyLabel.setText(String(format: "%d", daily))
        speedCalLabel.setText(String(format: "%d", game1))
        trueFalseLabel.setText(String(format: "%d", game2))
        operatorLabel.setText(String(format: "%d", game3))
        
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
