//
//  GameSetting.swift
//  brainexecise
//
//  Created by Petch Temeeyasen on 5/19/15.
//  Copyright (c) 2015 meesoft. All rights reserved.
//

class GameSetting{
    var gameMode: Int = 0  //0=cal, 1=true/false, 2=operation, 3=lowtohigh, 4=stroop test.
    var isPractice: Bool = true
    
    var level: Int = 1
    
    var maxLevel: Int = 1
    
    var isFirstTime: Bool = true
    
    var isPlayed: Bool = false
    
    var todayScore: Int = 0
    
    var hiscore: Int = 0
    
    var sender: AnyObject?
    
    init(gameMode: Int, isPractice: Bool, level: Int, firstTime: Bool, hiscore: Int, score: Int, maxLevel: Int=2, sender: AnyObject? = nil) {
        self.gameMode = gameMode
        self.isPractice = isPractice
        
        self.level = level
        self.maxLevel = maxLevel
        self.isFirstTime = firstTime
        self.isPlayed = firstTime
        self.hiscore = hiscore
        self.todayScore = score
        
        self.sender = sender
    }
}