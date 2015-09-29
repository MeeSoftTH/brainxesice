//
//  SummaryViewController.swift
//  brainexecise
//
//  Created by Petch Temeeyasen on 5/19/15.
//  Copyright (c) 2015 meesoft. All rights reserved.
//

import WatchKit

class SummaryViewController: WKInterfaceController {
    
    @IBOutlet weak var summaryLabel: WKInterfaceLabel!
    @IBOutlet weak var totalScoreLabel: WKInterfaceLabel!
    @IBOutlet weak var scoreLabel: WKInterfaceLabel!
    @IBOutlet weak var incorrectLabel: WKInterfaceLabel!
    @IBOutlet weak var incorrectMultiply: WKInterfaceLabel!
    @IBOutlet weak var fineLabel: WKInterfaceLabel!
    @IBOutlet weak var totalLabel: WKInterfaceLabel!
    
    var delegate: GameSelectionViewController?
    var gameMode: Int = -1
    
    override func awakeWithContext(context: AnyObject?) {
        super.awakeWithContext(context)
        
        if let setting = context as? NSDictionary {
            self.gameMode = setting["gamemode"] as! Int
            
            self.delegate = setting["sender"] as? GameSelectionViewController
            let score = setting["score"] as! Int
            let level = setting["level"] as! Int
            let correct = setting["correct"] as! Int
            let incorrect = setting["incorrect"] as! Int
            //let totalScore = score - (incorrect * level)
            
            let userSetting: NSUserDefaults! = NSUserDefaults(suiteName: "group.brainexecise")
            //var currentHiscore = 10
            var hiscores: [Int] = [10, 10, 10]
            var hiscoreKey = ""
            switch gameMode
            {
            case 0 :
                summaryLabel.setText(String(format: "Speed Cal LV %d", level))
                hiscoreKey = "scoresgame1"
                break
            case 1 :
                summaryLabel.setText(String(format: "True or False LV %d", level))
                hiscoreKey = "scoresgame2"
                break
            case 2 :
                summaryLabel.setText(String(format: "Operators LV %d", level))
                hiscoreKey = "scoresgame3"
                break
            default :
                summaryLabel.setText("Summary")
            }
            
            if gameMode <= 2 {
                hiscores = userSetting.objectForKey(hiscoreKey) as! [Int]
                
                if score > hiscores[0] {
                    summaryLabel.setText("Hiscore Break!!")
                    hiscores[0] = score
                    userSetting.setObject(hiscores, forKey: hiscoreKey)
                }
            }
            
            totalScoreLabel.setText(String(format: "%d", score))
            scoreLabel.setText(String(format: "%d", correct))
            incorrectLabel.setText(String(format: "%d", incorrect))
            if incorrect > 0 {
                incorrectMultiply.setText(String(format: "Fine x %d", level))
                fineLabel.setText(String(format: "-%d", level * incorrect))
                incorrectMultiply.setTextColor(UIColor.redColor())
                fineLabel.setTextColor(UIColor.redColor())
            }
            totalLabel.setText(String(format: "%d", score))
            
            self.setTitle("Done")
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

    @IBAction func closeClick() {
        self.dismissController()
    }

}
