//
//  GmaeScore.swift
//  brainexecise
//
//  Created by Pawarit Bunrith on 10/20/2558 BE.
//  Copyright © 2558 meesoft. All rights reserved.
//

class GameScore {
    var score: Int = 0
    var level: Int = 1
    var correct: Int = 0
    var incorrect: Int = 0
    var star: Int = 0
    
    var gameMode: Int = 0
    var bonusMode: Int = 0 // 4=low to high, 5=stroop test , 0= none.
    var sender: AnyObject?
    
    required init(score: Int, correct: Int, incorrect: Int, star: Int, level : Int, gameMode: Int, bonusMode: Int, sender: AnyObject? = nil){
        self.score = score
        self.correct = correct
        self.incorrect = incorrect
        self.level = level
        self.star = star
        self.gameMode = gameMode
        self.bonusMode = bonusMode
        self.sender = sender
    }
}