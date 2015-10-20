//
//  DailySummaryViewController.swift
//  brainexecise
//
//  Created by Pawarit Bunrith on 10/20/2558 BE.
//  Copyright © 2558 meesoft. All rights reserved.
//

import UIKit

class DailySummaryViewController: UIViewController {

    @IBOutlet weak var levelUpLabel: UILabel!
    @IBOutlet weak var summaryLabel: UILabel!
    @IBOutlet weak var scoreLabel: UILabel!
    @IBOutlet weak var starLabel: UILabel!
    
    @IBOutlet weak var unlockPanel: UIView!
    @IBOutlet weak var unlockLabel: UILabel!

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let context: AnyObject = self
        
        if let setting = context as? NSDictionary {
            
            let isBreak = setting["hiscorebreak"] as! Bool
            let score = setting["score"] as! Int
            let star = setting["star"] as! Int
            let unlockMsg = setting["msg"] as! String
            
            if isBreak {
                summaryLabel.text = "Hiscore break!!"
            }
            
            if unlockMsg != "" {
                unlockLabel.text = String(format: "%@",unlockMsg)
                unlockPanel.alpha = 1.0
            }
            else {
                unlockPanel.alpha = 0.0
                unlockLabel.text = ""
            }
            
            scoreLabel.text = String(format: "%d", score)
            
            var starStr = ""
            if star > 0 {
                for var index = 0; index < star; ++index {
                    starStr = starStr  + "★"
                }
            }
            else {
                starStr = "- - -"
            }
            
            starLabel.text = starStr
        }
        self.title = "Done"

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}
