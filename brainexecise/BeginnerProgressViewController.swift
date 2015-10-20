//
//  BeginnerProgressViewController.swift
//  brainexecise
//
//  Created by Pawarit Bunrith on 10/20/2558 BE.
//  Copyright © 2558 meesoft. All rights reserved.
//

import UIKit

class BeginnerProgressViewController: UIViewController {

    @IBOutlet weak var badge1: UIImageView!
    @IBOutlet weak var badge2: UIImageView!
    @IBOutlet weak var badge3: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let userSetting: NSUserDefaults! = NSUserDefaults(suiteName: "group.brainexecise")
        
        let progress = userSetting.integerForKey("rankprogress") as Int
        let level = userSetting.integerForKey("level") as Int
        if progress >= 1 || level == 2 {
            badge1.alpha = 1.0
        }
        if progress >= 2 || level == 2 {
            badge2.alpha = 1.0
        }
        if progress > 2 || level == 2 {
            badge3.alpha = 1.0
        }


        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}
