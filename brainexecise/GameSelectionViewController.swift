//
//  GameSelectionViewController.swift
//  brainexecise
//
//  Created by Pawarit Bunrith on 10/9/2558 BE.
//  Copyright © 2558 meesoft. All rights reserved.
//

import UIKit

class GameSelectionViewController: UIViewController, ModalLevelSelectedDelegate, ModalGameOverDelegate  {
    
    @IBOutlet weak var game1Button: UIButton!
    @IBOutlet weak var game2Button: UIButton!
    @IBOutlet weak var game3Button: UIButton!
    @IBOutlet weak var game4Button: UIButton!
    
    var maxAvailableLevel: Int = 1
    var currentLevel: Int = 1
    var hiscores: [Int] = [10, 10, 10, 10, 10]
        //var lastGameMode: Int = 0

    override func viewDidLoad() {
        super.viewDidLoad()

        let userSetting: NSUserDefaults! = NSUserDefaults(suiteName: "group.brainexecise")
        
        let isPurchased = userSetting.boolForKey("ispurchased") as Bool
        let game1Unlock = userSetting.boolForKey("game1unlock") as Bool
        let game2Unlock = userSetting.boolForKey("game2unlock") as Bool
        let game3Unlock = userSetting.boolForKey("game3unlock") as Bool
        let game4Unlock = userSetting.boolForKey("game4unlock") as Bool
        
        self.currentLevel = userSetting.integerForKey("level") as Int
        self.maxAvailableLevel = self.currentLevel
        if game1Unlock || isPurchased {
            game1Button.enabled = true
        }
        
        if game2Unlock || isPurchased {
            game2Button.enabled = true
        }
        
        if game3Unlock || isPurchased {
            game3Button.enabled = true
        }
        
        if game4Unlock || isPurchased {
            game4Button.enabled = true
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func selectedLevelDelegate(level: Int) {
        self.currentLevel = level
        NSLog(String(format:"selected level: %d", self.currentLevel))
        self.dismissViewControllerAnimated(true, completion: nil)
        print("Closed")
    }
    
    func gameOverDelegate(gameScore: GameScore!) {
        if gameScore != nil {
            self.dismissViewControllerAnimated(true, completion: nil)
            
            if gameScore.score > hiscores[gameScore.gameMode] {
                hiscores[gameScore.gameMode] = gameScore.score
            }
            
            presentControllerWithName("Summary", context: ["segue": "pagebased", "level": self.currentLevel, "score": gameScore.score, "correct" : gameScore.correct, "incorrect": gameScore.incorrect, "gamemode": gameScore.gameMode, "sender": self])
        }
    }
    
    @IBAction func calGameClick() {
        let option = GameSetting(gameMode:0, isPractice: true, level: self.currentLevel, firstTime: true, hiscore: hiscores[0], score: 0, sender: self)
        pushControllerWithName("GameView",context: option)
    }
    
    @IBAction func trueFalseGameClick() {
        let option = GameSetting(gameMode:1, isPractice: true, level: self.currentLevel, firstTime: true, hiscore: hiscores[1], score: 0, sender: self)
        pushControllerWithName("GameView",context: option)
    }
    
    @IBAction func operationGameClick() {
        let option = GameSetting(gameMode:2, isPractice: true, level: self.currentLevel, firstTime: true, hiscore: hiscores[2], score: 0, sender: self)
        pushControllerWithName("GameView",context: option)
    }
    
    @IBAction func lowHighGameClick() {
        pushControllerWithName("Low2High", context: ["segue": "hierarchical", "level": self.currentLevel, "practice": true, "sender": self])
    }
    
    @IBAction func selectLevelClick() {
        pushControllerWithName("LevelSelect", context: ["segue": "hierarchical", "level": self.currentLevel, "gamemode" : -1, "maxlevel": maxAvailableLevel, "sender": self])
    }


}
