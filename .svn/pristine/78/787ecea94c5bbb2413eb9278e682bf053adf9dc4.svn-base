//
//  InterfaceController.swift
//  brainexecise WatchKit Extension
//
//  Created by Petch Temeeyasen on 5/19/15.
//  Copyright (c) 2015 meesoft. All rights reserved.
//

import WatchKit

class InterfaceController: WKInterfaceController, ModalGameOverDelegate {
    
    @IBOutlet weak var practiceButton: WKInterfaceButton!
    
    private var isTestMode: Bool = true
    private var isPlayedToday: Bool = false
    private var game1Unlock: Bool = false
    private var game2Unlock: Bool = false
    private var game3Unlock: Bool = false
    private var game4Unlock: Bool = false
    private var game5Unlock: Bool = false
    private var practiceUnlock: Bool = false
    private var beginProgress1Pass: Bool = false
    private var beginProgress2Pass: Bool = false
    private var beginProgress3Pass: Bool = false
    private var currentLevel: Int = 0
    
    override func awakeWithContext(context: AnyObject?) {
        super.awakeWithContext(context)
        
        let userSetting: NSUserDefaults! = NSUserDefaults(suiteName: "group.brainexecise")
        
        if let isFirstTimeDone = userSetting.boolForKey("isdonefirsttime") as Bool? {
            if !isFirstTimeDone {
                userSetting.setBool(true, forKey: "isdonefirsttime")
                userSetting.setBool(false, forKey: "ispurchased")
                userSetting.setBool(false, forKey: "ispurchased2")
                userSetting.setBool(false, forKey: "iswatchscore")
                userSetting.setObject("Beginner", forKey: "rank")
                userSetting.setInteger(1, forKey: "level")
                userSetting.setInteger(0, forKey: "rankprogress")
                userSetting.setInteger(3, forKey: "maxprogress")
                
                userSetting.setBool(false, forKey: "practicemode")
                
                userSetting.setInteger(0, forKey: "dailyplay")
                userSetting.setInteger(0, forKey: "game1play")
                userSetting.setInteger(0, forKey: "game2play")
                userSetting.setInteger(0, forKey: "game3play")
                userSetting.setInteger(0, forKey: "game4play")
                userSetting.setInteger(0, forKey: "game5play")
                userSetting.setInteger(0, forKey: "totalplay")
                
                userSetting.setBool(false, forKey: "game1unlock")
                userSetting.setBool(false, forKey: "game2unlock")
                userSetting.setBool(false, forKey: "game3unlock")
                userSetting.setBool(false, forKey: "game4unlock")
                userSetting.setBool(false, forKey: "game5unlock")
                
                userSetting.setBool(false, forKey: "beginnerprogress1")
                userSetting.setBool(false, forKey: "beginnerprogress2")
                userSetting.setBool(false, forKey: "beginnerprogress3")
                
                userSetting.setInteger(10, forKey: "hiscore")
                userSetting.setInteger(1, forKey: "topgame")
                userSetting.setInteger(0, forKey: "hiscore1")
                userSetting.setInteger(0, forKey: "hiscore2")
                userSetting.setInteger(0, forKey: "hiscore3")
                userSetting.setInteger(0, forKey: "todayscore")
                
                let lastestDate: NSDate = NSDate(timeIntervalSince1970: 0)
                
                userSetting.setObject(lastestDate, forKey: "lastdate")
                
                userSetting.setObject([10, 10, 10], forKey: "scoresgame1") // top 3 hiscore of speed cal game for practise mode.
                userSetting.setObject([10, 10, 10], forKey: "scoresgame2")
                userSetting.setObject([10, 10, 10], forKey: "scoresgame3")
            }
            if let lastDate = userSetting.objectForKey("lastdate") as? NSDate {
                let calender = NSCalendar.currentCalendar()
                if calender.isDateInToday(lastDate) {
                    self.isPlayedToday = self.isTestMode ? false : true
                }
            }
            
            game1Unlock = userSetting.boolForKey("game1unlock")
            game2Unlock = userSetting.boolForKey("game2unlock")
            game3Unlock = userSetting.boolForKey("game3unlock")
            game4Unlock = userSetting.boolForKey("game4unlock")
            game5Unlock = userSetting.boolForKey("game5unlock")
            practiceUnlock = userSetting.boolForKey("practicemode")
            
            if practiceUnlock {
                practiceButton.setEnabled(true)
            }
            var level = userSetting.integerForKey("level") as Int
            if level == 1 {
                beginProgress1Pass = userSetting.boolForKey("beginnerprogress1")
                beginProgress2Pass = userSetting.boolForKey("beginnerprogress2")
                beginProgress3Pass = userSetting.boolForKey("beginnerprogress3")
            }
        }
    }

    override func willActivate() {
        // This method is called when watch view controller is about to be visible to user
        super.willActivate()
        
        if self.practiceUnlock {
            practiceButton.setEnabled(true)
        }
    }

    override func didDeactivate() {
        // This method is called when watch view controller is no longer visible
        super.didDeactivate()
    }
    
    func gameOverDelegate(gameScore: GameScore!) {
        if gameScore != nil {
            // Store information.
            var isUpdateProgress: Bool = false
            var msg: String = ""
            let userSetting: NSUserDefaults! = NSUserDefaults(suiteName: "group.brainexecise")
            
            if !isPlayedToday {
                userSetting.setInteger(gameScore.score, forKey: "todayscore")
                let lastestDate: NSDate = NSDate()
                userSetting.setObject(lastestDate, forKey: "lastdate")
                let dailyCount = increasePlayedStat(userSetting, key: "dailyplay")
                if dailyCount == 3 {
                    msg = "'True/False' game\n was unlock."
                }
                else if dailyCount == 4 {
                    msg = "'Operator' game\n was unlock."
                }
                else {
                    if dailyCount >= 10 && !game2Unlock {
                        game2Unlock = true
                        userSetting.setBool(true, forKey: "game2unlock")
                        msg = "'True/False' practice\n was unlock."
                    }
                }
            }
            
            var hiscoreBreak: Bool = false
            var hiscore = userSetting.integerForKey("hiscore") as Int
            if gameScore.score > hiscore {
                userSetting.setInteger(gameScore.score, forKey: "hiscore")
                userSetting.setBool(true, forKey: "iswatchscore")
                userSetting.setInteger(gameScore.gameMode + 1, forKey: "topgame")
                hiscoreBreak = true
            }
            
            switch gameScore.gameMode
            {
            case 0 :
                increasePlayedStat(userSetting, key: "game1play")
                let game1Break = updateHiscore(userSetting, key: "hiscore1", score: gameScore.score)
                if game1Break && !isPlayedToday && gameScore.level == 1 && !beginProgress1Pass {
                    isUpdateProgress = true
                    self.beginProgress1Pass = true
                }
                break
            case 1 :
                increasePlayedStat(userSetting, key: "game2play")
                let game2Break = updateHiscore(userSetting, key: "hiscore2", score: gameScore.score)
                if game2Break && !isPlayedToday && gameScore.level == 1 && !beginProgress2Pass {
                    isUpdateProgress = true
                    self.beginProgress2Pass = true
                }
                break
            case 2 :
                increasePlayedStat(userSetting, key: "game3play")
                let game3Break = updateHiscore(userSetting, key: "hiscore3", score: gameScore.score)
                if game3Break && !isPlayedToday && gameScore.level == 1 && !beginProgress3Pass {
                    isUpdateProgress = true
                    self.beginProgress3Pass = true
                }
                break
            default :
                break
            }
            
            if gameScore.bonusMode == 4 {
                let game4PlayCount = increasePlayedStat(userSetting, key: "game4play")
                if game4PlayCount >= 30 && !game4Unlock && practiceUnlock {
                    game4Unlock = true
                    userSetting.setBool(true, forKey: "game4unlock")
                    msg = "'Low2High' practice\n was unlock."
                }
                
            }
            else if gameScore.bonusMode == 5 {
                let game5PlayCount = increasePlayedStat(userSetting, key: "game5play")
                if game5PlayCount >= 30 && !game5Unlock && practiceUnlock{
                    game5Unlock = true
                    userSetting.setBool(true, forKey: "game5unlock")
                    msg = "'Stroop' practice\n was unlock."
                }
                
            }
            if gameScore.star >= 3 && gameScore.level == 2 {
                isUpdateProgress = true
            }
            
            let totalPlayCount = increasePlayedStat(userSetting, key: "totalplay")
            if totalPlayCount >= 30 && !game3Unlock && practiceUnlock {
                game3Unlock = true
                userSetting.setBool(true, forKey: "game3unlock")
                msg = "'Operator' practice\n was unlock."
            }
            
            // comment this for test.
            self.isPlayedToday = self.isTestMode ? false : true
            
            var isLevelUp: Bool = false
            if isUpdateProgress {
                let res = increaseProgress(userSetting)
                isLevelUp = res.levelUp
                if res.msg != "" {
                    msg = res.msg
                }
            }
            
            popController()
            
            var names: [String] = []
            var contexts: [AnyObject] = [["segue": "pagebased", "score": gameScore.score, "star": gameScore.star, "hiscorebreak" : hiscoreBreak, "msg" : msg, "sender": self]]
            if self.currentLevel == 1 {
                let progress = userSetting.integerForKey("rankprogress")
                
                if isLevelUp {
                    names = ["DailySummary", "BeginnerProgress", "ProProgress"]
                    contexts.append(["segue": "pagebased", "sender": self])
                    contexts.append(["segue": "pagebased", "sender": self])
                }
                else {
                    names = ["DailySummary", "BeginnerProgress"]
                    contexts.append(["segue": "pagebased", "sender": self])
                }
            }
            else if self.currentLevel == 2 {
                names = ["DailySummary", "ProProgress"]
                contexts.append(["segue": "pagebased", "sender": self])
            }
            presentControllerWithNames(names, contexts: contexts)
        }
    }
    
    @IBAction func playClick() {
        let userSetting: NSUserDefaults! = NSUserDefaults(suiteName: "group.brainexecise")
        
        var hiscore = userSetting.integerForKey("hiscore") as Int
        var level = userSetting.integerForKey("level") as Int
        self.currentLevel = level
        
        var dailyPlayCount = userSetting.integerForKey("dailyplay") as Int
        var game1PlayCount = userSetting.integerForKey("game1play") as Int
        var game2PlayCount = userSetting.integerForKey("game2play") as Int
        var game3PlayCount = userSetting.integerForKey("game3play") as Int
        
        var firstTimeGame1 = game1PlayCount == 0
        var firstTimeGame2 = game2PlayCount == 0
        var firstTimeGame3 = game3PlayCount == 0
        
        var rand: Int = 0
        if dailyPlayCount < 3 {
            rand = 0
        }
        else if dailyPlayCount == 3 {
            rand = 1
        }
        else if dailyPlayCount == 4 {
            rand = 2
        }
        else {
            rand = randomNumberBetween(0, max: 2)
        }
        //self.currentGameMode = rand
        
        switch(rand){
        case 1 :
            let option = GameSetting(gameMode:1, isPractice: false, level: level, firstTime: firstTimeGame2, hiscore: hiscore, score: 0, sender: self)
            pushControllerWithName("GameView",context: option)
            break
        case 2 :
            let option = GameSetting(gameMode:2, isPractice: false, level: level, firstTime: firstTimeGame3, hiscore: hiscore, score: 0, sender: self)
            pushControllerWithName("GameView",context: option)
            break
        default :
            let option = GameSetting(gameMode:0, isPractice: false, level: level, firstTime: firstTimeGame1, hiscore: hiscore, score: 0, sender: self)
            pushControllerWithName("GameView",context: option)
            break;
        }
    }
    
    func increaseProgress(setting: NSUserDefaults) -> (levelUp: Bool, msg: String) {
        var isLevelUp: Bool = false
        let level = setting.integerForKey("level")
        if level < 3 {
            let progress = setting.integerForKey("rankprogress")
            let max = setting.integerForKey("maxprogress")
            
            if progress + 1 == max {
                isLevelUp = true
                setting.setInteger(0, forKey: "rankprogress")
                setting.setInteger(level+1, forKey: "level")
                
                setting.setInteger(8, forKey: "maxprogress")
                if level + 1 == 2 {
                    setting.setObject("Pro", forKey: "rank")
                    // also unlock practice & cal mode.
                    
                    if !self.practiceUnlock {
                        game1Unlock = true
                        practiceButton.setEnabled(true)
                        practiceUnlock = true
                        setting.setBool(true, forKey: "game1unlock")
                        setting.setBool(true, forKey: "practicemode")
                        return (isLevelUp, "Practice mode \n+ 'Speed Cal' practice\n was unlock.")
                    }
                }
                else {
                    setting.setObject("Expert", forKey: "rank")
                }
            }
            else {
                setting.setInteger(progress + 1, forKey: "rankprogress")
            }
        }
        return (isLevelUp, "Your progress\n was updated.")
    }
    
    func updateHiscore(setting: NSUserDefaults, key: String, score: Int) -> Bool {
        var hiscore1 = setting.integerForKey(key) as Int
        if score > hiscore1 {
            setting.setInteger(score, forKey: key)
            return score > 10
        }
        return false
    }
    
    func increasePlayedStat(setting: NSUserDefaults, key: String) -> Int {
        var val = setting.integerForKey(key) as Int
        var res: Int = val + 1
        setting.setInteger(res, forKey: key)
        
        return res
    }
    
    func randomNumberBetween(min: Int, max: Int) -> Int {
        return Int(arc4random_uniform(UInt32(max - min + 1))) + min
    }

}
