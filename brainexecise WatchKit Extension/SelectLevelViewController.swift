//
//  SelectLevelViewController.swift
//  brainexecise
//
//  Created by Petch Temeeyasen on 5/19/15.
//  Copyright (c) 2015 meesoft. All rights reserved.
//

import WatchKit

protocol ModalLevelSelectedDelegate {
    func selectedLevelDelegate(level: Int)
}

class SelectLevelViewController: WKInterfaceController {
    
    @IBOutlet weak var level1Button: WKInterfaceButton!
    @IBOutlet weak var level2Button: WKInterfaceButton!
    @IBOutlet weak var level3Button: WKInterfaceButton!
    @IBOutlet weak var currentSelectLabel: WKInterfaceLabel!
    @IBOutlet weak var setButton: WKInterfaceButton!
    
    var delegate: GameSelectionViewController?
    var selectedLevel: Int = 1
    var defaultColor: UIColor = UIColor(red: 120.0/255.0, green:63.0/255.0, blue:4.0/255.0, alpha:1.0)
    var selectedColor: UIColor = UIColor.brownColor()
    
    override func awakeWithContext(context: AnyObject?) {
        super.awakeWithContext(context)
        
        if let setting = context as? NSDictionary {
            selectedLevel = setting["level"] as! Int
            self.delegate = setting["sender"] as? GameSelectionViewController
            
            let max = setting["maxlevel"] as! Int
           
            if max > 1 {
                level2Button.setEnabled(true)
            }
            if max > 2 {
                level3Button.setEnabled(true)
            }
            if selectedLevel == 1 {
                level1Click()
            }
            else if selectedLevel == 2 {
                level2Click()
            }
            else if selectedLevel == 3 {
                level3Click()
            }
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
    
    @IBAction func level1Click() {
        
        level1Button.setBackgroundColor(selectedColor)
        level2Button.setBackgroundColor(defaultColor)
        level3Button.setBackgroundColor(defaultColor)
        currentSelectLabel.setText("You choose: 1")
        selectedLevel = 1
    }
    @IBAction func level2Click() {
        level1Button.setBackgroundColor(defaultColor)
        level2Button.setBackgroundColor(selectedColor)
        level3Button.setBackgroundColor(defaultColor)
        currentSelectLabel.setText("You choose: 2")
        selectedLevel=2
    }
    
    @IBAction func level3Click() {
        level1Button.setBackgroundColor(defaultColor)
        level2Button.setBackgroundColor(defaultColor)
        level3Button.setBackgroundColor(selectedColor)
        currentSelectLabel.setText("You choose: 3")
        selectedLevel=3
    }
    
    @IBAction func startGameClick() {
        self.delegate?.selectedLevelDelegate(selectedLevel)
    }
}
