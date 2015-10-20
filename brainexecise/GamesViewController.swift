//
//  GamesViewController.swift
//  brainexecise
//
//  Created by Pawarit Bunrith on 10/9/2558 BE.
//  Copyright © 2558 meesoft. All rights reserved.
//

import UIKit

protocol ModalGameOverDelegate {
    func gameOverDelegate(gameScore: GameScore!)
}

class GamesViewController: UIViewController {
    
    @IBOutlet weak var scoreLabel: UILabel!
    @IBOutlet weak var incorrectLabel: UILabel!
    @IBOutlet weak var statusLabel: UILabel!
    @IBOutlet weak var gameNameLabel: UILabel!
    @IBOutlet weak var questionLabel: UILabel!
    
    @IBOutlet weak var countdownLabel: UILabel!
    @IBOutlet weak var answer1Button: UIButton!
    @IBOutlet weak var answer2Button: UIButton!
    
    var delegate: GameSelectionViewController?
    var mainGameDelegate: ViewController?
    var defaultColor: UIColor = UIColor(red: 120.0/255.0, green:63.0/255.0, blue:4.0/255.0, alpha:1.0)
    var selectedColor: UIColor = UIColor.brownColor()
    
    var gameSetting: GameSetting!
    var isPractice: Bool = false
    var trueSide: Int = 0
    var score: Int = 0
    var incorrect: Int = 0
    var correctCount: Int = 0
    var bonusProgress: Int = 0
    var star: Int = 0
    var bonusMode: Int = 0
    
    var button1Title: String!
    var button2Title: String!
    
    var countDown = 3;
    var countDownTimer: NSTimer!
    var gameTimer: NSTimer!
    var duration: NSTimeInterval = 31.0
    var elapsedTime: NSTimeInterval = 0.0
    var startTime = NSDate()
    var isPause: Bool = false
    
    var isGameOver: Bool = false
    var isShowBonusStage: Bool = false
    var scoreReported: Bool = false
    
    let gameQuestions1Lv1: [Question] = [Question(text: "0 + 1 = ?", choice1: "1", choice2: "2"),
        Question(text: "0 + 3 = ?", choice1: "3", choice2: "4"),
        Question(text: "1 + 1 = ?", choice1: "2", choice2: "3"),
        Question(text: "1 + 2 = ?", choice1: "3", choice2: "4"),
        Question(text: "1 + 5 = ?", choice1: "6", choice2: "7"),
        Question(text: "1 + 7 = ?", choice1: "8", choice2: "9"),
        Question(text: "1 + 8 = ?", choice1: "9", choice2: "10"),
        Question(text: "1 + 9 = ?", choice1: "10", choice2: "11"),
        Question(text: "2 + 1 = ?", choice1: "3", choice2: "4"),
        Question(text: "2 + 3 = ?", choice1: "5", choice2: "6"),
        Question(text: "2 + 5 = ?", choice1: "7", choice2: "8"),
        Question(text: "2 + 7 = ?", choice1: "9", choice2: "10"),
        Question(text: "3 + 1 = ?", choice1: "4", choice2: "5"),
        Question(text: "3 + 4 = ?", choice1: "7", choice2: "8"),
        Question(text: "3 + 5 = ?", choice1: "8", choice2: "9"),
        Question(text: "3 + 6 = ?", choice1: "9", choice2: "10"),
        Question(text: "3 + 8 = ?", choice1: "11", choice2: "12"),
        Question(text: "4 + 3 = ?", choice1: "7", choice2: "8"),
        Question(text: "4 + 5 = ?", choice1: "9", choice2: "10"),
        Question(text: "4 + 6 = ?", choice1: "10", choice2: "11"),
        Question(text: "4 + 8 = ?", choice1: "12", choice2: "13"),
        Question(text: "5 + 2 = ?", choice1: "7", choice2: "8"),
        Question(text: "5 + 3 = ?", choice1: "8", choice2: "9"),
        Question(text: "5 + 4 = ?", choice1: "9", choice2: "10"),
        Question(text: "5 + 6 = ?", choice1: "11", choice2: "12"),
        Question(text: "5 + 7 = ?", choice1: "12", choice2: "13"),
        Question(text: "5 + 8 = ?", choice1: "13", choice2: "14"),
        Question(text: "6 + 1 = ?", choice1: "7", choice2: "8"),
        Question(text: "6 + 2 = ?", choice1: "8", choice2: "9"),
        Question(text: "6 + 3 = ?", choice1: "9", choice2: "10"),
        Question(text: "6 + 4 = ?", choice1: "10", choice2: "11"),
        Question(text: "6 + 5 = ?", choice1: "11", choice2: "12"),
        Question(text: "6 + 7 = ?", choice1: "13", choice2: "14"),
        Question(text: "6 + 9 = ?", choice1: "15", choice2: "16"),
        Question(text: "7 + 1 = ?", choice1: "8", choice2: "9"),
        Question(text: "7 + 2 = ?", choice1: "9", choice2: "10"),
        Question(text: "7 + 3 = ?", choice1: "10", choice2: "11"),
        Question(text: "7 + 4 = ?", choice1: "11", choice2: "12"),
        Question(text: "7 + 5 = ?", choice1: "12", choice2: "13"),
        Question(text: "7 + 6 = ?", choice1: "13", choice2: "14"),
        Question(text: "8 + 3 = ?", choice1: "11", choice2: "12"),
        Question(text: "8 + 4 = ?", choice1: "12", choice2: "13"),
        Question(text: "8 + 5 = ?", choice1: "13", choice2: "14"),
        Question(text: "8 + 8 = ?", choice1: "16", choice2: "17"),
        Question(text: "8 + 9 = ?", choice1: "17", choice2: "18"),
        Question(text: "9 + 0 = ?", choice1: "9", choice2: "10"),
        Question(text: "9 + 2 = ?", choice1: "11", choice2: "12"),
        Question(text: "9 + 3 = ?", choice1: "12", choice2: "13"),
        Question(text: "9 + 6 = ?", choice1: "15", choice2: "16"),
        Question(text: "9 + 7 = ?", choice1: "16", choice2: "17")]
    
    let gameQuestions1Lv2: [Question] = [Question(text: "2 − 1 = ?", choice1: "1", choice2: "2"),
        Question(text: "1 + 2 = ?", choice1: "3", choice2: "4"),
        Question(text: "2 − 2 = ?", choice1: "0", choice2: "1"),
        Question(text: "2 + 3 = ?", choice1: "5", choice2: "6"),
        Question(text: "3 − 1 = ?", choice1: "2", choice2: "3"),
        Question(text: "2 + 7 = ?", choice1: "9", choice2: "10"),
        Question(text: "3 − 2 = ?", choice1: "1", choice2: "2"),
        Question(text: "3 + 5 = ?", choice1: "8", choice2: "9"),
        Question(text: "4 − 2 = ?", choice1: "2", choice2: "3"),
        Question(text: "3 + 6 = ?", choice1: "9", choice2: "10"),
        Question(text: "5 − 3 = ?", choice1: "2", choice2: "3"),
        Question(text: "4 + 5 = ?", choice1: "9", choice2: "1"),
        Question(text: "5 − 4 = ?", choice1: "1", choice2: "2"),
        Question(text: "4 + 7 = ?", choice1: "11", choice2: "12"),
        Question(text: "6 − 3 = ?", choice1: "3", choice2: "4"),
        Question(text: "5 + 7 = ?", choice1: "12", choice2: "13"),
        Question(text: "6 − 4 = ?", choice1: "2", choice2: "3"),
        Question(text: "5 + 8 = ?", choice1: "13", choice2: "14"),
        Question(text: "6 − 5 = ?", choice1: "1", choice2: "2"),
        Question(text: "6 + 8 = ?", choice1: "14", choice2: "15"),
        Question(text: "7 − 3 = ?", choice1: "4", choice2: "5"),
        Question(text: "7 + 1 = ?", choice1: "8", choice2: "9"),
        Question(text: "7 − 4 = ?", choice1: "3", choice2: "4"),
        Question(text: "7 + 4 = ?", choice1: "11", choice2: "12"),
        Question(text: "7 − 5 = ?", choice1: "2", choice2: "3"),
        Question(text: "7 + 5 = ?", choice1: "12", choice2: "13"),
        Question(text: "7 − 7 = ?", choice1: "0", choice2: "1"),
        Question(text: "7 + 6 = ?", choice1: "13", choice2: "14"),
        Question(text: "8 − 2 = ?", choice1: "6", choice2: "7"),
        Question(text: "8 + 3 = ?", choice1: "11", choice2: "12"),
        Question(text: "8 − 5 = ?", choice1: "3", choice2: "4"),
        Question(text: "8 + 5 = ?", choice1: "13", choice2: "14"),
        Question(text: "9 − 2 = ?", choice1: "7", choice2: "8"),
        Question(text: "8 + 6 = ?", choice1: "14", choice2: "15"),
        Question(text: "9 − 3 = ?", choice1: "6", choice2: "7"),
        Question(text: "8 + 7 = ?", choice1: "15", choice2: "16"),
        Question(text: "9 − 4 = ?", choice1: "5", choice2: "6"),
        Question(text: "8 + 8 = ?", choice1: "16", choice2: "18"),
        Question(text: "9 − 7 = ?", choice1: "2", choice2: "3"),
        Question(text: "8 + 9 = ?", choice1: "17", choice2: "18"),
        Question(text: "11 − 6 = ?", choice1: "5", choice2: "6"),
        Question(text: "9 + 2 = ?", choice1: "11", choice2: "12"),
        Question(text: "11 − 7 = ?", choice1: "4", choice2: "5"),
        Question(text: "9 + 3 = ?", choice1: "12", choice2: "13"),
        Question(text: "13 − 7 = ?", choice1: "6", choice2: "7"),
        Question(text: "9 + 6 = ?", choice1: "15", choice2: "16"),
        Question(text: "13 − 8 = ?", choice1: "5", choice2: "6"),
        Question(text: "9 + 7 = ?", choice1: "16", choice2: "17"),
        Question(text: "18 − 9 = ?", choice1: "9", choice2: "8"),
        Question(text: "9 + 8 = ?", choice1: "17", choice2: "18")]
    
    let gameQuestions1Lv3: [Question] = [Question(text: "2 − 1 = ?", choice1: "1", choice2: "2"),
        Question(text: "1 + 2 = ?", choice1: "3", choice2: "4"),
        Question(text: "0 × 9 = ?", choice1: "0", choice2: "9"),
        Question(text: "2 − 2 = ?", choice1: "0", choice2: "1"),
        Question(text: "2 + 3 = ?", choice1: "5", choice2: "6"),
        Question(text: "2 × 7 = ?", choice1: "14", choice2: "9"),
        Question(text: "3 − 1 = ?", choice1: "2", choice2: "3"),
        Question(text: "2 + 7 = ?", choice1: "9", choice2: "10"),
        Question(text: "2 × 9 = ?", choice1: "18", choice2: "7"),
        Question(text: "3 − 2 = ?", choice1: "1", choice2: "2"),
        Question(text: "3 + 5 = ?", choice1: "8", choice2: "9"),
        Question(text: "3 × 2 = ?", choice1: "6", choice2: "5"),
        Question(text: "0 ÷ 28 = ?", choice1: "0", choice2: "1"),
        Question(text: "4 − 2 = ?", choice1: "2", choice2: "3"),
        Question(text: "3 + 6 = ?", choice1: "9", choice2: "10"),
        Question(text: "9 ÷ 3 = ?", choice1: "3", choice2: "2"),
        Question(text: "5 − 3 = ?", choice1: "2", choice2: "3"),
        Question(text: "4 + 5 = ?", choice1: "9", choice2: "1"),
        Question(text: "3 × 9 = ?", choice1: "27", choice2: "12"),
        Question(text: "5 − 4 = ?", choice1: "1", choice2: "2"),
        Question(text: "4 + 7 = ?", choice1: "11", choice2: "12"),
        Question(text: "24 ÷ 6 = ?", choice1: "4", choice2: "6"),
        Question(text: "6 − 3 = ?", choice1: "3", choice2: "4"),
        Question(text: "5 + 7 = ?", choice1: "12", choice2: "13"),
        Question(text: "4 × 7 = ?", choice1: "28", choice2: "32"),
        Question(text: "6 − 4 = ?", choice1: "2", choice2: "3"),
        Question(text: "5 + 8 = ?", choice1: "13", choice2: "14"),
        Question(text: "28 ÷ 7 = ?", choice1: "4", choice2: "8"),
        Question(text: "6 − 5 = ?", choice1: "1", choice2: "2"),
        Question(text: "6 + 8 = ?", choice1: "14", choice2: "15"),
        Question(text: "5 × 8 = ?", choice1: "40", choice2: "13"),
        Question(text: "7 − 3 = ?", choice1: "4", choice2: "5"),
        Question(text: "7 + 1 = ?", choice1: "8", choice2: "9"),
        Question(text: "32 ÷ 4 = ?", choice1: "8", choice2: "7"),
        Question(text: "7 − 4 = ?", choice1: "3", choice2: "4"),
        Question(text: "7 + 4 = ?", choice1: "11", choice2: "12"),
        Question(text: "6 × 4 = ?", choice1: "24", choice2: "20"),
        Question(text: "7 − 5 = ?", choice1: "2", choice2: "3"),
        Question(text: "7 + 5 = ?", choice1: "12", choice2: "13"),
        Question(text: "36 ÷ 9 = ?", choice1: "4", choice2: "6"),
        Question(text: "7 − 7 = ?", choice1: "0", choice2: "1"),
        Question(text: "7 + 6 = ?", choice1: "13", choice2: "14"),
        Question(text: "6 × 6 = ?", choice1: "36", choice2: "12"),
        Question(text: "8 − 2 = ?", choice1: "6", choice2: "7"),
        Question(text: "8 + 3 = ?", choice1: "11", choice2: "12"),
        Question(text: "7 × 7 = ?", choice1: "49", choice2: "14"),
        Question(text: "8 − 5 = ?", choice1: "3", choice2: "4"),
        Question(text: "8 + 5 = ?", choice1: "13", choice2: "14"),
        Question(text: "8 × 2 = ?", choice1: "16", choice2: "10"),
        Question(text: "9 − 2 = ?", choice1: "7", choice2: "8"),
        Question(text: "8 + 6 = ?", choice1: "14", choice2: "15"),
        Question(text: "8 × 6 = ?", choice1: "48", choice2: "42"),
        Question(text: "9 − 3 = ?", choice1: "6", choice2: "7"),
        Question(text: "8 + 7 = ?", choice1: "15", choice2: "16"),
        Question(text: "8 × 8 = ?", choice1: "64", choice2: "48"),
        Question(text: "9 − 4 = ?", choice1: "5", choice2: "6"),
        Question(text: "8 + 8 = ?", choice1: "16", choice2: "18"),
        Question(text: "42 ÷ 7 = ?", choice1: "6", choice2: "7"),
        Question(text: "9 − 7 = ?", choice1: "2", choice2: "3"),
        Question(text: "8 + 9 = ?", choice1: "17", choice2: "18"),
        Question(text: "8 × 9 = ?", choice1: "72", choice2: "81"),
        Question(text: "11 − 6 = ?", choice1: "5", choice2: "6"),
        Question(text: "9 + 2 = ?", choice1: "11", choice2: "12"),
        Question(text: "48 ÷ 8 = ?", choice1: "6", choice2: "5"),
        Question(text: "11 − 7 = ?", choice1: "4", choice2: "5"),
        Question(text: "9 + 3 = ?", choice1: "12", choice2: "13"),
        Question(text: "9 × 4 = ?", choice1: "36", choice2: "13"),
        Question(text: "13 − 7 = ?", choice1: "6", choice2: "7"),
        Question(text: "9 + 6 = ?", choice1: "15", choice2: "16"),
        Question(text: "64 ÷ 8 = ?", choice1: "8", choice2: "16"),
        Question(text: "13 − 8 = ?", choice1: "5", choice2: "6"),
        Question(text: "9 + 7 = ?", choice1: "16", choice2: "17"),
        Question(text: "9 × 9 = ?", choice1: "81", choice2: "82"),
        Question(text: "18 − 9 = ?", choice1: "9", choice2: "8"),
        Question(text: "9 + 8 = ?", choice1: "17", choice2: "18"),
        Question(text: "72 ÷ 9 = ?", choice1: "8", choice2: "9")]
    
    let gameQuestions2Lv1: [Question] = [Question(text: "0 + 1 = 1", choice1: "1", choice2: ""),
        Question(text: "0 + 3 = 0", choice1: "0", choice2: ""),
        Question(text: "1 + 1 = 2", choice1: "1", choice2: ""),
        Question(text: "1 + 2 = 12", choice1: "0", choice2: ""),
        Question(text: "1 + 5 = 6", choice1: "1", choice2: ""),
        Question(text: "1 + 7 = 17", choice1: "0", choice2: ""),
        Question(text: "1 + 8 = 9", choice1: "1", choice2: ""),
        Question(text: "1 + 9 = 19", choice1: "0", choice2: ""),
        Question(text: "2 + 1 = 3", choice1: "1", choice2: ""),
        Question(text: "2 + 3 = 13", choice1: "0", choice2: ""),
        Question(text: "2 + 5 = 7", choice1: "1", choice2: ""),
        Question(text: "2 + 7 = 8", choice1: "0", choice2: ""),
        Question(text: "3 + 1 = 4", choice1: "1", choice2: ""),
        Question(text: "3 + 4 = 17", choice1: "0", choice2: ""),
        Question(text: "3 + 5 = 8", choice1: "1", choice2: ""),
        Question(text: "3 + 6 = 11", choice1: "0", choice2: ""),
        Question(text: "3 + 8 = 11", choice1: "1", choice2: ""),
        Question(text: "4 + 3 = 12", choice1: "0", choice2: ""),
        Question(text: "4 + 5 = 9", choice1: "1", choice2: ""),
        Question(text: "4 + 6 = 12", choice1: "0", choice2: ""),
        Question(text: "4 + 8 = 12", choice1: "1", choice2: ""),
        Question(text: "5 + 2 = 3", choice1: "0", choice2: ""),
        Question(text: "5 + 3 = 8", choice1: "1", choice2: ""),
        Question(text: "5 + 4 = 8", choice1: "0", choice2: ""),
        Question(text: "5 + 6 = 11", choice1: "1", choice2: ""),
        Question(text: "5 + 7 = 13", choice1: "0", choice2: ""),
        Question(text: "5 + 8 = 13", choice1: "1", choice2: ""),
        Question(text: "6 + 1 = 5", choice1: "0", choice2: ""),
        Question(text: "6 + 2 = 8", choice1: "1", choice2: ""),
        Question(text: "6 + 3 = 12", choice1: "0", choice2: ""),
        Question(text: "6 + 4 = 10", choice1: "1", choice2: ""),
        Question(text: "6 + 5 = 10", choice1: "0", choice2: ""),
        Question(text: "6 + 7 = 13", choice1: "1", choice2: ""),
        Question(text: "6 + 9 = 14", choice1: "0", choice2: ""),
        Question(text: "7 + 1 = 8", choice1: "1", choice2: ""),
        Question(text: "7 + 2 = 10", choice1: "0", choice2: ""),
        Question(text: "7 + 3 = 10", choice1: "1", choice2: ""),
        Question(text: "7 + 4 = 14", choice1: "0", choice2: ""),
        Question(text: "7 + 5 = 12", choice1: "1", choice2: ""),
        Question(text: "7 + 6 = 14", choice1: "0", choice2: ""),
        Question(text: "8 + 3 = 11", choice1: "1", choice2: ""),
        Question(text: "8 + 4 = 10", choice1: "0", choice2: ""),
        Question(text: "8 + 5 = 13", choice1: "1", choice2: ""),
        Question(text: "8 + 8 = 18", choice1: "0", choice2: ""),
        Question(text: "8 + 9 = 17", choice1: "1", choice2: ""),
        Question(text: "9 + 0 = 10", choice1: "0", choice2: ""),
        Question(text: "9 + 2 = 11", choice1: "1", choice2: ""),
        Question(text: "9 + 3 = 10", choice1: "0", choice2: ""),
        Question(text: "9 + 6 = 15", choice1: "1", choice2: ""),
        Question(text: "9 + 7 = 17", choice1: "0", choice2: "")]
    
    let gameQuestions2Lv2: [Question] = [Question(text: "0 + 7 = 0", choice1: "0", choice2: ""),
        Question(text: "1 + 5 = 6", choice1: "1", choice2: ""),
        Question(text: "2 + 5 = 7", choice1: "1", choice2: ""),
        Question(text: "2 + 7 = 8", choice1: "0", choice2: ""),
        Question(text: "3 + 4 = 17", choice1: "0", choice2: ""),
        Question(text: "3 + 8 = 11", choice1: "1", choice2: ""),
        Question(text: "4 + 3 = 12", choice1: "0", choice2: ""),
        Question(text: "4 + 5 = 9", choice1: "1", choice2: ""),
        Question(text: "4 + 6 = 12", choice1: "0", choice2: ""),
        Question(text: "5 + 4 = 8", choice1: "0", choice2: ""),
        Question(text: "5 + 7 = 13", choice1: "0", choice2: ""),
        Question(text: "6 + 4 = 10", choice1: "1", choice2: ""),
        Question(text: "6 + 7 = 13", choice1: "1", choice2: ""),
        Question(text: "6 + 9 = 14", choice1: "0", choice2: ""),
        Question(text: "7 + 4 = 14", choice1: "0", choice2: ""),
        Question(text: "7 + 5 = 12", choice1: "1", choice2: ""),
        Question(text: "7 + 6 = 14", choice1: "0", choice2: ""),
        Question(text: "8 + 3 = 11", choice1: "1", choice2: ""),
        Question(text: "8 + 5 = 13", choice1: "1", choice2: ""),
        Question(text: "8 + 8 = 18", choice1: "0", choice2: ""),
        Question(text: "8 + 9 = 17", choice1: "1", choice2: ""),
        Question(text: "9 + 2 = 11", choice1: "1", choice2: ""),
        Question(text: "9 + 7 = 17", choice1: "0", choice2: ""),
        Question(text: "1 − 1 = 0", choice1: "1", choice2: ""),
        Question(text: "2 − 0 = 0", choice1: "0", choice2: ""),
        Question(text: "3 − 1 = 2", choice1: "1", choice2: ""),
        Question(text: "3 − 3 = 6", choice1: "0", choice2: ""),
        Question(text: "4 − 2 = 2", choice1: "1", choice2: ""),
        Question(text: "5 − 1 = 6", choice1: "0", choice2: ""),
        Question(text: "5 − 3 = 2", choice1: "1", choice2: ""),
        Question(text: "6 − 3 = 9", choice1: "0", choice2: ""),
        Question(text: "6 − 4 = 2", choice1: "1", choice2: ""),
        Question(text: "6 − 5 = 11", choice1: "0", choice2: ""),
        Question(text: "7 − 2 = 5", choice1: "1", choice2: ""),
        Question(text: "7 − 3 = 10", choice1: "0", choice2: ""),
        Question(text: "7 − 6 = 1", choice1: "1", choice2: ""),
        Question(text: "8 − 3 = 11", choice1: "0", choice2: ""),
        Question(text: "8 − 4 = 4", choice1: "1", choice2: ""),
        Question(text: "9 − 1 = 9", choice1: "0", choice2: ""),
        Question(text: "9 − 7 = 2", choice1: "1", choice2: "")]
    
    // Not implement question.
    let gameQuestions2Lv3: [Question] = [Question(text: "8 + 9 = 17", choice1: "1", choice2: "")]
    
    let gameQuestions3Lv1: [Question] = [Question(text: "2 □ 1 = 1", choice1: "−", choice2: "+"),
        Question(text: "1 □ 2 = 3", choice1: "1", choice2: "+"),
        Question(text: "2 □ 2 = 0", choice1: "0", choice2: "+"),
        Question(text: "2 □ 3 = 5", choice1: "1", choice2: "+"),
        Question(text: "3 □ 1 = 2", choice1: "0", choice2: "+"),
        Question(text: "2 □ 7 = 9", choice1: "1", choice2: "+"),
        Question(text: "3 □ 2 = 1", choice1: "0", choice2: "+"),
        Question(text: "3 □ 5 = 8", choice1: "1", choice2: "+"),
        Question(text: "4 □ 2 = 2", choice1: "0", choice2: "+"),
        Question(text: "3 □ 6 = 9", choice1: "1", choice2: "+"),
        Question(text: "5 □ 3 = 2", choice1: "0", choice2: "+"),
        Question(text: "4 □ 5 = 9", choice1: "1", choice2: "+"),
        Question(text: "5 □ 4 = 1", choice1: "0", choice2: "+"),
        Question(text: "4 □ 7 = 11", choice1: "1", choice2: "+"),
        Question(text: "6 □ 3 = 3", choice1: "0", choice2: "+"),
        Question(text: "5 □ 7 = 12", choice1: "1", choice2: "+"),
        Question(text: "6 □ 4 = 2", choice1: "0", choice2: "+"),
        Question(text: "5 □ 8 = 13", choice1: "1", choice2: "+"),
        Question(text: "6 □ 5 = 1", choice1: "0", choice2: "+"),
        Question(text: "6 □ 8 = 14", choice1: "1", choice2: "+"),
        Question(text: "7 □ 3 = 4", choice1: "0", choice2: "+"),
        Question(text: "7 □ 1 = 8", choice1: "1", choice2: "+"),
        Question(text: "7 □ 4 = 3", choice1: "0", choice2: "+"),
        Question(text: "7 □ 4 = 11", choice1: "1", choice2: "+"),
        Question(text: "7 □ 5 = 2", choice1: "0", choice2: "+"),
        Question(text: "7 □ 5 = 12", choice1: "1", choice2: "+"),
        Question(text: "7 □ 7 = 0", choice1: "0", choice2: "+"),
        Question(text: "7 □ 6 = 13", choice1: "1", choice2: "+"),
        Question(text: "8 □ 2 = 6", choice1: "0", choice2: "+"),
        Question(text: "8 □ 3 = 11", choice1: "1", choice2: "+"),
        Question(text: "8 □ 5 = 3", choice1: "0", choice2: "+"),
        Question(text: "8 □ 5 = 13", choice1: "1", choice2: "+"),
        Question(text: "9 □ 2 = 7", choice1: "0", choice2: "+"),
        Question(text: "8 □ 6 = 14", choice1: "1", choice2: "+"),
        Question(text: "9 □ 3 = 6", choice1: "0", choice2: "+"),
        Question(text: "8 □ 7 = 15", choice1: "1", choice2: "+"),
        Question(text: "9 □ 4 = 5", choice1: "0", choice2: "+"),
        Question(text: "8 □ 8 = 16", choice1: "1", choice2: "+"),
        Question(text: "9 □ 7 = 2", choice1: "0", choice2: "+"),
        Question(text: "8 □ 9 = 17", choice1: "1", choice2: "+"),
        Question(text: "11 □ 6 = 5", choice1: "0", choice2: "+"),
        Question(text: "9 □ 2 = 11", choice1: "1", choice2: "+"),
        Question(text: "11 □ 7 = 4", choice1: "0", choice2: "+"),
        Question(text: "9 □ 3 = 12", choice1: "1", choice2: "+"),
        Question(text: "13 □ 7 = 6", choice1: "0", choice2: "+"),
        Question(text: "9 □ 6 = 15", choice1: "1", choice2: "+"),
        Question(text: "13 □ 8 = 5", choice1: "0", choice2: "+"),
        Question(text: "9 □ 7 = 16", choice1: "1", choice2: "+"),
        Question(text: "18 □ 9 = 9", choice1: "0", choice2: "+"),
        Question(text: "9 □ 8 = 17", choice1: "1", choice2: "+")]
    
    let gameQuestions3Lv2: [Question] = [Question(text: "11 □ 6 = 5", choice1: "0", choice2: "+")]
    
    let gameQuestions3Lv3: [Question] = [Question(text: "11 □ 6 = 5", choice1: "0", choice2: "+")]
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
        
    }
    
    override func viewWillAppear(animated: Bool) {
        if self.isGameOver {
            answer1Button.enabled = false
            answer2Button.enabled = false
        }
        else {
            // Resume form dim.
            if self.isPause {
                countDownTimer = NSTimer.scheduledTimerWithTimeInterval(duration - elapsedTime,
                    target: self,
                    selector: Selector("gameOver"),
                    userInfo: nil,
                    repeats: false)

                countdownLabel.text = String(NSDate(timeIntervalSinceNow: duration - elapsedTime))
                startTime = NSDate(timeIntervalSinceNow: duration - elapsedTime)
                self.isPause = false
            }
        }

        super.viewDidAppear(animated)
    }
    
    override func viewDidDisappear(animated: Bool) {
        if !self.isGameOver {
            let paused = NSDate()
            self.elapsedTime += paused.timeIntervalSinceDate(startTime)
            gameTimer.invalidate()
            //self.countdownLabel.stop()
            self.isPause = true
        }
        else {
            if self.isGameOver && !self.scoreReported && !self.isShowBonusStage {
                goToSummaryPage()
            }
            if countDownTimer != nil {
                countDownTimer.invalidate()
                countDownTimer = nil
            }
            if gameTimer != nil {
                gameTimer.invalidate()
                gameTimer = nil
            }
        }

        super.viewDidDisappear(animated)
    }
    
    override func viewDidLoad() {
    
        if let setting: AnyObject = GameSetting.self {
            
            gameSetting = setting as? GameSetting
            if (setting.isPractice != nil) {
                self.delegate = gameSetting.sender as? GameSelectionViewController
            }
                
            else {
                self.mainGameDelegate = gameSetting.sender as? ViewController
            }
            
            switch(gameSetting.gameMode){
            case 0:
                self.gameNameLabel.text = String(format: "Speed Cal LV %d", setting.level)
                break
            case 1:
                self.gameNameLabel.text = String(format: "True or False LV %d", setting.level)
                break
            case 2:
                self.gameNameLabel.text = String(format: "Operators LV %d", setting.level)
                break
            default:
                self.gameNameLabel.text = ""
            }
            
            self.isPractice = setting.isPractice
            
            incorrectLabel.alpha = 0.0
            statusLabel.text = ""
            answer1Button.backgroundColor = defaultColor
            answer2Button.backgroundColor = defaultColor
            answer1Button.setTitle("", forState: .Normal)
            answer2Button.setTitle("", forState: .Normal)
            // set countdown label.
            //var date = NSDate(timeIntervalSinceNow: self.duration) // 31)
            //countdownLabel.setDate(date)
            
            countDownTimer = NSTimer.scheduledTimerWithTimeInterval(1.0,
                target: self,
                selector: Selector("countdown"),
                userInfo: nil,
                repeats: true)
        }
        
        super.viewDidLoad()
    }
    
    @IBAction func answer1Click() {
        if !self.isGameOver {
            updateScore(trueSide == 0)
        }
    }
    
    @IBAction func answer2Click() {
        if !self.isGameOver {
            updateScore(trueSide == 1)
        }
    }
    
    func updateScore(correct: Bool){
        if correct {
            self.bonusProgress++
            var bonusGain: Bool = false
            if self.bonusProgress == 5 && !self.isPractice  {
                self.bonusProgress = 0
                self.star++
                bonusGain = true
                var str = ""
                for var index = 0; index < star; ++index {
                    str = str  + "★"
                }
                gameNameLabel.text = str
            }
            let plus = bonusGain ? gameSetting.level * 2 : gameSetting.level
            statusLabel.text = String(format: "+%d", plus) //"+1")
            score += plus //score++
            scoreLabel.text = String(format: "Score: %d", score)
            correctCount++;
        }
        else {
            self.bonusProgress = 0
            incorrectLabel.alpha = 1.0
            statusLabel.textColor = UIColor.redColor()
            let minus = gameSetting.level
            statusLabel.text = String(format: "-%d", minus) //"+1")
            //statusLabel.setText("-1")
            score -= minus
            if score < 0 {
                score = 0
            }
            scoreLabel.text = String(format: "Score: %d", score)
            incorrect++
            incorrectLabel.text = String(format: "X: %d", incorrect)
            
        }
        NSTimer.scheduledTimerWithTimeInterval(0.5,
            target: self,
            selector: Selector("clearStat"),
            userInfo: nil,
            repeats: false)
        
        answer1Button.enabled = false
        answer2Button.enabled = false
        if !isGameOver {
            getQuestion()
        }
    }
    
    func clearStat() {
        statusLabel.textColor = UIColor.whiteColor()
        statusLabel.text = ""
    }
    
    func countdown() {
        if countDown == 0 {
            // invalidate and stop timer.
            gameNameLabel.text = "" // ★★★
            countDownTimer.invalidate()
            countDownTimer = nil
            
            self.bonusProgress = 0
            self.correctCount = 0
            
            self.startTime = NSDate()
            //let date = NSDate(timeIntervalSinceNow: self.duration)
            //countdownLabel.setDate(date)
            //countdownLabel.start()
            
            gameTimer = NSTimer.scheduledTimerWithTimeInterval(self.duration,
                target: self,
                selector: Selector("gameOver"),
                userInfo: nil,
                repeats: false)
            
            getQuestion()
        }
        else {
            questionLabel.text = String(format:"%d", countDown)
            countDown--
        }
    }
    
    func gameOver(){
        isGameOver = true
        answer1Button.enabled = false
        answer2Button.enabled = false
        
        if self.star >= 3 {
            self.bonusMode = 4
            self.isShowBonusStage = true
            questionLabel.text = "★Bonus★"
            NSTimer.scheduledTimerWithTimeInterval(3.0,
                target: self,
                selector: Selector("goToBonusStage"),
                userInfo: nil,
                repeats: false)
        }
        else {
            questionLabel.text = "Game Over"
            
            NSTimer.scheduledTimerWithTimeInterval(3.0,
                target: self,
                selector: Selector("goToSummaryPage"),
                userInfo: nil,
                repeats: false)
        }
    }
    
    func goToBonusStage(){
        //pushControllerWithName("Low2High", context: ["segue": "hierarchical", "level": self.gameSetting.level, "practice": false, "sender": self])
    }
    
    func bonusEndDelegate(score: Int){
        self.isShowBonusStage = false
        //popController()
        answer1Button.enabled = false
        answer2Button.enabled = false
        self.score = self.score + score
        questionLabel.text = "Game Over"
        
        NSTimer.scheduledTimerWithTimeInterval(3.0,
            target: self,
            selector: Selector("goToSummaryPage"),
            userInfo: nil,
            repeats: false)
    }
    
    func goToSummaryPage(){
        //let scoreCard = GameScore(score : self.score, correct: self.correctCount, incorrect: self.incorrect, star: self.star, level : gameSetting.level, gameMode: gameSetting.gameMode, bonusMode: self.bonusMode)
        
        if gameSetting.isPractice {
            //self.delegate?.gameOverDelegate(scoreCard)
        }
        else {
            //self.mainGameDelegate?.gameOverDelegate(scoreCard)
        }
        self.scoreReported = true
    }
    
    func getQuestion() {
        var q: Question?
        
        if gameSetting.gameMode == 0 {
            trueSide = randomNumberBetween(0, max: 1)
            if(gameSetting.level == 1){
                let rand = randomNumberBetween(0, max: gameQuestions1Lv1.count - 1)
                q = gameQuestions1Lv1[rand]
            }
            else if(gameSetting.level == 2){
                let rand = randomNumberBetween(0, max: gameQuestions1Lv2.count - 1)
                q = gameQuestions1Lv2[rand]
            }
            else {
                let rand = randomNumberBetween(0, max: gameQuestions1Lv3.count - 1)
                q = gameQuestions1Lv3[rand]
            }
            if(q != nil){
                button1Title = trueSide == 0 ? q?.choice1 : q?.choice2
                button2Title = trueSide == 0 ? q?.choice2 : q?.choice1
            }
            
        }
        else if gameSetting.gameMode == 1 {
            if(gameSetting.level == 1){
                let rand = randomNumberBetween(0, max: gameQuestions2Lv1.count - 1)
                q = gameQuestions2Lv1[rand]
            }
            else if(gameSetting.level == 2){
                let rand = randomNumberBetween(0, max: gameQuestions2Lv2.count - 1)
                q = gameQuestions2Lv2[rand]
            }
            else {
                let rand = randomNumberBetween(0, max: gameQuestions2Lv3.count - 1)
                q = gameQuestions2Lv3[rand]
            }
            if q != nil {
                trueSide = q?.choice1 == "1" ? 0 : 1
                button1Title = "✓" // "True"
                button2Title = "✕" // "False"
            }
        }
        else if gameSetting.gameMode == 2 {
            if(gameSetting.level == 1){
                let rand = randomNumberBetween(0, max: gameQuestions3Lv1.count - 1)
                q = gameQuestions3Lv1[rand]
            }
            else if(gameSetting.level == 2){
                let rand = randomNumberBetween(0, max: gameQuestions3Lv2.count - 1)
                q = gameQuestions3Lv2[rand]
            }
            else {
                let rand = randomNumberBetween(0, max: gameQuestions3Lv3.count - 1)
                q = gameQuestions3Lv3[rand]
            }
            if q != nil {
                
                trueSide = q?.choice1 == "1" ? 0 : 1
                button1Title = q?.choice2 == "+" ? "+" : "×"
                button2Title = q?.choice2 == "+" ? "−" : "÷"
            }
        }
        
        if q != nil && !self.isGameOver {
            questionLabel.text = q?.text
            answer1Button.setTitle(button1Title, forState: .Normal)
            answer2Button.setTitle(button2Title, forState: .Normal)
            answer1Button.enabled = false
            answer2Button.enabled = false
        }
    }
    
    func randomNumberBetween(min: Int, max: Int) -> Int {
        return Int(arc4random_uniform(UInt32(max - min + 1))) + min
    }
}
