//
//  DailySummaryController.swift
//  brainexecise
//
//  Created by Petch Temeeyasen on 5/29/15.
//  Copyright (c) 2015 meesoft. All rights reserved.
//

import WatchKit

class DailySummaryController: WKInterfaceController {
    
    @IBOutlet weak var levelUpLabel: WKInterfaceLabel!
    @IBOutlet weak var summaryLabel: WKInterfaceLabel!
    @IBOutlet weak var scoreLabel: WKInterfaceLabel!
    @IBOutlet weak var starLabel: WKInterfaceLabel!
    
    @IBOutlet weak var unlockPanel: WKInterfaceGroup!
    @IBOutlet weak var unlockLabel: WKInterfaceLabel!
    
    override func awakeWithContext(context: AnyObject?) {
        super.awakeWithContext(context)
        
        if let setting = context as? NSDictionary {
            
            let isBreak = setting["hiscorebreak"] as! Bool
            let score = setting["score"] as! Int
            let star = setting["star"] as! Int
            let unlockMsg = setting["msg"] as! String
            
            if isBreak {
                summaryLabel.setText("Hiscore break!!")
            }
            
            if unlockMsg != "" {
                unlockLabel.setText(String(format: "%@",unlockMsg))
                unlockPanel.setAlpha(1.0)
            }
            else {
                unlockPanel.setAlpha(0)
                unlockLabel.setText("")
            }
            
            scoreLabel.setText(String(format: "%d", score))
            
            var starStr = ""
            if star > 0 {
                for var index = 0; index < star; ++index {
                    starStr = starStr  + "★"
                }
            }
            else {
                starStr = "- - -"
            }
            
            starLabel.setText(starStr)
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
