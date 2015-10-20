//
//  SelectLevelViewController.swift
//  brainexecise
//
//  Created by Pawarit Bunrith on 10/20/2558 BE.
//  Copyright © 2558 meesoft. All rights reserved.
//

import UIKit

protocol ModalLevelSelectedDelegate {
    func selectedLevelDelegate(level: Int)
}

class SelectLevelViewController: UIViewController {
    
    @IBOutlet weak var level1Button: UIButton!
    @IBOutlet weak var level2Button: UIButton!
    @IBOutlet weak var level3Button: UIButton!
    @IBOutlet weak var currentSelectLabel: UILabel!
    @IBOutlet weak var setButton: UIButton!
    
    var delegate: GameSelectionViewController?
    var selectedLevel: Int = 1
    var defaultColor: UIColor = UIColor(red: 120.0/255.0, green:63.0/255.0, blue:4.0/255.0, alpha:1.0)
    var selectedColor: UIColor = UIColor.brownColor()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let context: AnyObject = self
        
        if let setting = context as? NSDictionary {
            selectedLevel = setting["level"] as! Int
            self.delegate = setting["sender"] as? GameSelectionViewController
            
            let max = setting["maxlevel"] as! Int
            
            if max > 1 {
                level2Button.enabled = true
            }
            if max > 2 {
                level3Button.enabled = true
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
        
        
        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func level1Click() {
        
        level1Button.backgroundColor = selectedColor
        level2Button.backgroundColor = defaultColor
        level3Button.backgroundColor = defaultColor
        currentSelectLabel.text = "You choose: 1"
        selectedLevel = 1
    }
    @IBAction func level2Click() {
        level1Button.backgroundColor = defaultColor
        level2Button.backgroundColor = selectedColor
        level3Button.backgroundColor = defaultColor
        currentSelectLabel.text = "You choose: 2"
        selectedLevel = 2
    }
    
    @IBAction func level3Click() {
        level1Button.backgroundColor = defaultColor
        level2Button.backgroundColor = defaultColor
        level3Button.backgroundColor = selectedColor
        currentSelectLabel.text = "You choose: 3"
        selectedLevel = 3
    }
    
    @IBAction func startGameClick() {
        self.delegate?.selectedLevelDelegate(selectedLevel)
    }
    
}
