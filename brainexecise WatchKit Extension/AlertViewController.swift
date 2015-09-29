//
//  AlertViewController.swift
//  brainexecise
//
//  Created by Petch Temeeyasen on 6/2/15.
//  Copyright (c) 2015 meesoft. All rights reserved.
//

import WatchKit

class AlertViewController : WKInterfaceController {
    @IBOutlet weak var titleLabel: WKInterfaceLabel!
    @IBOutlet weak var messageLabel: WKInterfaceLabel!
    override func awakeWithContext(context: AnyObject?) {
        super.awakeWithContext(context)
        
        if let setting = context as? NSDictionary {
            
            
            let title = setting["title"] as! String
            let messgae = setting["msg"] as! String
            titleLabel.setText(title)
            messageLabel.setText(messgae)
        }
        self.setTitle("")
    }
    
    override func willActivate() {
        // This method is called when watch view controller is about to be visible to user
        super.willActivate()
    }
    
    override func didDeactivate() {
        // This method is called when watch view controller is no longer visible
        super.didDeactivate()
    }
    
    @IBAction func dismissClick() {
        self.dismissController()
    }
}
