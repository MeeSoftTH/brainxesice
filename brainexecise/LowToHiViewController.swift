//
//  LowToHiViewController.swift
//  brainexecise
//
//  Created by Pawarit Bunrith on 10/20/2558 BE.
//  Copyright © 2558 meesoft. All rights reserved.
//

import UIKit

protocol ModalBonusDelegate {
    func bonusEndDelegate(score: Int)
}

class LowToHiViewController: UIViewController {

    var delegate: GameSelectionViewController?
    var mainGameDelegate: GameViewController?
    
    @IBOutlet weak var gameLabel: UILabel!
    @IBOutlet weak var scoreLabel: UILabel!
    @IBOutlet weak var button1: UIButton!
    @IBOutlet weak var button2: UIButton!
    @IBOutlet weak var button3: UIButton!
    @IBOutlet weak var button4: UIButton!
    @IBOutlet weak var button5: UIButton!
    @IBOutlet weak var button6: UIButton!
    @IBOutlet weak var button7: UIButton!
    @IBOutlet weak var button8: UIButton!
    @IBOutlet weak var button9: UIButton!
    
    private var level = 1
    private var isPractice: Bool = true
    private var step = 3 // start with 3
    private var currentIndex = 0
    
    private var score: Int = 0
    private var correct: Int = 0
    private var buttonVals: [Int] = []
    private var answers: [Int] = []
    
    private var countDown = 2;
    private var countDownTimer: NSTimer!
    private var nextTimer: NSTimer!
    private var isGameOver: Bool = false
    private var isPlayable: Bool = false
    private var isInitialized: Bool = false
    private var isClosing: Bool = false

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let context: AnyObject = self

        if let setting = context as? NSDictionary {
            
            self.isPractice = setting["practice"] as! Bool
            self.level = setting["level"] as! Int
            if self.isPractice {
                self.delegate = setting["sender"] as? GameSelectionViewController
                gameLabel.text = String(format: "Low2High LV %d", self.level)
            }
            else {
                self.mainGameDelegate = setting["sender"] as? GameViewController
                gameLabel.text = "Low 2 High"
                self.title = "Bonus"
            }
            scoreLabel.alpha = 0.0
            button1.enabled = false
            button2.enabled = false
            button3.enabled = false
            button4.enabled = false
            button5.enabled = false
            button6.enabled = false
            button7.enabled = false
            button8.enabled = false
            button9.enabled = false
            
            countDownTimer = NSTimer.scheduledTimerWithTimeInterval(1.0,
                target: self,
                selector: Selector("countdown"),
                userInfo: nil,
                repeats: true)
            
        }

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func countdown() {
        if self.countDown == 0 {
            // invalidate and stop timer.
            gameLabel.text = ""
            scoreLabel.alpha = 1.0
            self.currentIndex = 0
            countDownTimer.invalidate()
            countDownTimer = nil
            
            if !isInitialized {
                nextQuestion(self.step)
                isInitialized = true
            }
            else {
                emptyAllButtons()
                enableAllButtons()
                self.isPlayable = true
            }
        }
        else {
            if self.isInitialized {
                gameLabel.text = String(format:"Ready %d", countDown)
            }
            self.countDown--
        }
    }
    
    func doNextStep(){
        if !self.isGameOver {
            gameLabel.text = ""
            clearButtons(1.0)
            nextQuestion(self.step)
        }
        else {
            let scoreCard = GameScore(score : self.score, correct: self.correct, incorrect: 0, star: 0, level : self.level, gameMode: 3, bonusMode: 4)
            
            if self.isPractice {
                self.delegate?.gameOverDelegate(scoreCard)
            }
            else {
                self.mainGameDelegate?.bonusEndDelegate(self.score)
            }
            self.isClosing = true
        }
    }
    
    @IBAction func button1Click() {
        if self.isPlayable && self.buttonVals[0] != 0 {
            button1.setTitle(String(format:"%d", self.buttonVals[0]), forState: .Normal)
            
            if self.answers[currentIndex] == self.buttonVals[0] {
                increaseScore()
            }
            else {
                button1.backgroundColor = UIColor.redColor()
                doGameOver()
            }
            button1.enabled = false
        }
    }
    
    @IBAction func button2Click() {
        if self.isPlayable && self.buttonVals[1] != 0 {
            button2.setTitle(String(format:"%d", self.buttonVals[1]), forState: .Normal)
            
            if self.answers[currentIndex] == self.buttonVals[1] {
                increaseScore()
            }
            else {
                button2.backgroundColor = UIColor.redColor()
                doGameOver()
            }
            button2.enabled = false
        }
    }
    
    @IBAction func button3Click() {
        if self.isPlayable && self.buttonVals[2] != 0 {
            button3.setTitle(String(format:"%d", self.buttonVals[2]), forState: .Normal)
            
            if self.answers[currentIndex] == self.buttonVals[2] {
                increaseScore()
            }
            else {
                button3.backgroundColor = UIColor.redColor()
                doGameOver()
            }
            button3.enabled = false
        }
    }
    
    @IBAction func button4Click() {
        if self.isPlayable && self.buttonVals[3] != 0 {
            button4.setTitle(String(format:"%d", self.buttonVals[3]), forState: .Normal)
            
            if self.answers[currentIndex] == self.buttonVals[3] {
                increaseScore()
            }
            else {
                button4.backgroundColor = UIColor.redColor()
                doGameOver()
            }
            button4.enabled = false
        }
    }
    
    @IBAction func button5Click() {
        if self.isPlayable && self.buttonVals[4] != 0 {
            button5.setTitle(String(format:"%d", self.buttonVals[4]), forState: .Normal)
            
            if self.answers[currentIndex] == self.buttonVals[4] {
                increaseScore()
            }
            else {
                button5.backgroundColor = UIColor.redColor()
                doGameOver()
            }
            button5.enabled = false
        }
    }
    
    @IBAction func button6Click() {
        if self.isPlayable && self.buttonVals[5] != 0 {
            button6.setTitle(String(format:"%d", self.buttonVals[5]), forState: .Normal)
            
            if self.answers[currentIndex] == self.buttonVals[5] {
                increaseScore()
            }
            else {
                button6.backgroundColor = UIColor.redColor()
                doGameOver()
            }
            button6.enabled = false
        }
    }
    
    @IBAction func button7Click() {
        if self.isPlayable && self.buttonVals[6] != 0 {
            button7.setTitle(String(format:"%d", self.buttonVals[6]), forState: .Normal)
            
            if self.answers[currentIndex] == self.buttonVals[6] {
                increaseScore()
            }
            else {
                button7.backgroundColor = UIColor.redColor()
                doGameOver()
            }
            button7.enabled = false
        }
    }
    
    @IBAction func button8Click() {
        if self.isPlayable && self.buttonVals[7] != 0 {
            button8.setTitle(String(format:"%d", self.buttonVals[7]), forState: .Normal)
            
            if self.answers[currentIndex] == self.buttonVals[7] {
                increaseScore()
            }
            else {
                button8.backgroundColor = UIColor.redColor()
                doGameOver()
            }
            button8.enabled = false
        }
    }
    
    @IBAction func button9Click() {
        if self.isPlayable && self.buttonVals[8] != 0 {
            button9.setTitle(String(format:"%d", self.buttonVals[8]), forState: .Normal)
            
            if self.answers[currentIndex] == self.buttonVals[8] {
                increaseScore()
            }
            else {
                button9.backgroundColor = UIColor.redColor()
                doGameOver()
            }
            button9.enabled = false
        }
    }
    
    func nextQuestion(step: Int){
        var infos: [Int] = []
        if self.level == 1 {
            for index in 1...step {
                infos.append(index)
            }
        }
        else if self.level == 2 {
            let from = 7
            let to = (step - 1) + 7
            for index in from...to {
                infos.append(index)
            }
        }
        else {
            var temp: [Int] = []
            for index in 1...32 {
                temp.append(index)
            }
            
            var tempShuffle: [Int] = shuffle(temp)
            for index in 1...step {
                infos.append(tempShuffle[index-1])
            }
            infos = infos.sort(<)
        }
        
        clearButtons()
        
        self.answers  = infos
        let shufffled = shuffle(infos)
        switch (step){
        case 3:
            button4.setTitle(String(format:"%d", shufffled[0]), forState: .Normal)
            button5.setTitle(String(format:"%d", shufffled[1]), forState: .Normal)
            button6.setTitle(String(format:"%d", shufffled[2]), forState: .Normal)
            
            buttonVals[3] = shufffled[0]
            buttonVals[4] = shufffled[1]
            buttonVals[5] = shufffled[2]
            
            button4.alpha = 1.0
            button5.alpha = 1.0
            button6.alpha = 1.0
            
            break
        case 4:
            button2.setTitle(String(format:"%d", shufffled[0]), forState: .Normal)
            button4.setTitle(String(format:"%d", shufffled[1]), forState: .Normal)
            button6.setTitle(String(format:"%d", shufffled[2]), forState: .Normal)
            button8.setTitle(String(format:"%d", shufffled[3]), forState: .Normal)
            
            buttonVals[1] = shufffled[0]
            buttonVals[3] = shufffled[1]
            buttonVals[5] = shufffled[2]
            buttonVals[7] = shufffled[3]
            
            button2.alpha = 1.0
            button4.alpha = 1.0
            button6.alpha = 1.0
            button8.alpha = 1.0
            break
        case 5:
            button1.setTitle(String(format:"%d", shufffled[0]), forState: .Normal)
            button3.setTitle(String(format:"%d", shufffled[1]), forState: .Normal)
            button5.setTitle(String(format:"%d", shufffled[2]), forState: .Normal)
            button7.setTitle(String(format:"%d", shufffled[3]), forState: .Normal)
            button9.setTitle(String(format:"%d", shufffled[4]), forState: .Normal)
            
            buttonVals[0] = shufffled[0]
            buttonVals[2] = shufffled[1]
            buttonVals[4] = shufffled[2]
            buttonVals[6] = shufffled[3]
            buttonVals[8] = shufffled[4]
            
            button1.alpha = 1.0
            button3.alpha = 1.0
            button5.alpha = 1.0
            button7.alpha = 1.0
            button9.alpha = 1.0
            break
        case 6:
            button1.setTitle(String(format:"%d", shufffled[0]), forState: .Normal)
            button2.setTitle(String(format:"%d", shufffled[1]), forState: .Normal)
            button3.setTitle(String(format:"%d", shufffled[2]), forState: .Normal)
            button5.setTitle(String(format:"%d", shufffled[3]), forState: .Normal)
            button6.setTitle(String(format:"%d", shufffled[4]), forState: .Normal)
            button9.setTitle(String(format:"%d", shufffled[5]), forState: .Normal)
            
            buttonVals[0] = shufffled[0]
            buttonVals[1] = shufffled[1]
            buttonVals[2] = shufffled[2]
            buttonVals[4] = shufffled[3]
            buttonVals[5] = shufffled[4]
            buttonVals[8] = shufffled[5]
            
            button1.alpha = 1.0
            button2.alpha = 1.0
            button3.alpha = 1.0
            button5.alpha = 1.0
            button6.alpha = 1.0
            button9.alpha = 1.0
            
            break
        case 7:
            button1.setTitle(String(format:"%d", shufffled[0]), forState: .Normal)
            button2.setTitle(String(format:"%d", shufffled[1]), forState: .Normal)
            button3.setTitle(String(format:"%d", shufffled[2]), forState: .Normal)
            button4.setTitle(String(format:"%d", shufffled[3]), forState: .Normal)
            button5.setTitle(String(format:"%d", shufffled[4]), forState: .Normal)
            button6.setTitle(String(format:"%d", shufffled[5]), forState: .Normal)
            button9.setTitle(String(format:"%d", shufffled[6]), forState: .Normal)
            
            buttonVals[0] = shufffled[0]
            buttonVals[1] = shufffled[1]
            buttonVals[2] = shufffled[2]
            buttonVals[3] = shufffled[3]
            buttonVals[4] = shufffled[4]
            buttonVals[5] = shufffled[5]
            buttonVals[8] = shufffled[6]
            
            button1.alpha = 1.0
            button2.alpha = 1.0
            button3.alpha = 1.0
            button4.alpha = 1.0
            button5.alpha = 1.0
            button6.alpha = 1.0
            button9.alpha = 1.0
            break
        case 8:
            button1.setTitle(String(format:"%d", shufffled[0]), forState: .Normal)
            button2.setTitle(String(format:"%d", shufffled[1]), forState: .Normal)
            button3.setTitle(String(format:"%d", shufffled[2]), forState: .Normal)
            button4.setTitle(String(format:"%d", shufffled[3]), forState: .Normal)
            button6.setTitle(String(format:"%d", shufffled[4]), forState: .Normal)
            button7.setTitle(String(format:"%d", shufffled[5]), forState: .Normal)
            button8.setTitle(String(format:"%d", shufffled[6]), forState: .Normal)
            button9.setTitle(String(format:"%d", shufffled[7]), forState: .Normal)
            
            buttonVals[0] = shufffled[0]
            buttonVals[1] = shufffled[1]
            buttonVals[2] = shufffled[2]
            buttonVals[3] = shufffled[3]
            buttonVals[5] = shufffled[4]
            buttonVals[6] = shufffled[5]
            buttonVals[7] = shufffled[6]
            buttonVals[8] = shufffled[7]
            
            button1.alpha = 1.0
            button2.alpha = 1.0
            button3.alpha = 1.0
            button4.alpha = 1.0
            button6.alpha = 1.0
            button7.alpha = 1.0
            button8.alpha = 1.0
            button9.alpha = 1.0
            break
        case 9:
            button1.setTitle(String(format:"%d", shufffled[0]), forState: .Normal)
            button2.setTitle(String(format:"%d", shufffled[1]), forState: .Normal)
            button3.setTitle(String(format:"%d", shufffled[2]), forState: .Normal)
            button4.setTitle(String(format:"%d", shufffled[3]), forState: .Normal)
            button5.setTitle(String(format:"%d", shufffled[4]), forState: .Normal)
            button6.setTitle(String(format:"%d", shufffled[5]), forState: .Normal)
            button7.setTitle(String(format:"%d", shufffled[6]), forState: .Normal)
            button8.setTitle(String(format:"%d", shufffled[7]), forState: .Normal)
            button9.setTitle(String(format:"%d", shufffled[8]), forState: .Normal)
            
            buttonVals[0] = shufffled[0]
            buttonVals[1] = shufffled[1]
            buttonVals[2] = shufffled[2]
            buttonVals[3] = shufffled[3]
            buttonVals[4] = shufffled[4]
            buttonVals[5] = shufffled[5]
            buttonVals[6] = shufffled[6]
            buttonVals[7] = shufffled[7]
            buttonVals[8] = shufffled[8]
            
            button1.alpha = 1.0
            button2.alpha = 1.0
            button3.alpha = 1.0
            button4.alpha = 1.0
            button5.alpha = 1.0
            button6.alpha = 1.0
            button7.alpha = 1.0
            button8.alpha = 1.0
            button9.alpha = 1.0
            break
        default:
            break
        }
        
        //gameLabel.setText("")
        countDown = 3
        countDownTimer = NSTimer.scheduledTimerWithTimeInterval(1.0,
            target: self,
            selector: Selector("countdown"),
            userInfo: nil,
            repeats: true)
    }
    
    func clearButtons(alpha: CGFloat = 0.0){
        button1.alpha = alpha
        button2.alpha = alpha
        button3.alpha = alpha
        button4.alpha = alpha
        button5.alpha = alpha
        button6.alpha = alpha
        button7.alpha = alpha
        button8.alpha = alpha
        button9.alpha = alpha
        
        emptyAllButtons()
        
        if(alpha == 0.0){
            disableAllButtons()
        }
        
        buttonVals = [0, 0, 0, 0, 0, 0, 0, 0, 0]
    }
    
    func emptyAllButtons(){
        button1.setTitle("", forState: .Normal)
        button2.setTitle("", forState: .Normal)
        button3.setTitle("", forState: .Normal)
        button4.setTitle("", forState: .Normal)
        button5.setTitle("", forState: .Normal)
        button6.setTitle("", forState: .Normal)
        button7.setTitle("", forState: .Normal)
        button8.setTitle("", forState: .Normal)
        button9.setTitle("", forState: .Normal)
    }
    
    func enableAllButtons(){
        button1.enabled = true
        button2.enabled = true
        button3.enabled = true
        button4.enabled = true
        button5.enabled = true
        button6.enabled = true
        button7.enabled = true
        button8.enabled = true
        button9.enabled = true
    }
    
    func disableAllButtons(){
        button1.enabled = false
        button2.enabled = false
        button3.enabled = false
        button4.enabled = false
        button5.enabled = false
        button6.enabled = false
        button7.enabled = false
        button8.enabled = false
        button9.enabled = false
    }
    
    func increaseScore() {
        
        self.currentIndex++
        if self.currentIndex == self.answers.count {
            if self.isPractice {
                gameLabel.text = String(format:"+%d", self.currentIndex * self.level)
            }
            else {
                gameLabel.text = String(format:"Bonus +%d", self.currentIndex * self.level)
            }
            self.correct += self.currentIndex
            self.score += self.currentIndex * self.level
            scoreLabel.text = String(format: "Score: %d", self.score)
            self.currentIndex = 0
            self.step++
            self.isPlayable = false
            if self.step > 9 {
                // Game over.
                self.isGameOver = true
            }
            //scoreLabel.setAlpha(0)
            nextTimer = NSTimer.scheduledTimerWithTimeInterval(2.1,
                target: self,
                selector: Selector("doNextStep"),
                userInfo: nil,
                repeats: false)
        }
    }
    
    func doGameOver(){
        // reval all possible
        button1.setTitle(String(format:"%d", buttonVals[0]), forState: .Normal)
        button2.setTitle(String(format:"%d", buttonVals[1]), forState: .Normal)
        button3.setTitle(String(format:"%d", buttonVals[2]), forState: .Normal)
        button4.setTitle(String(format:"%d", buttonVals[3]), forState: .Normal)
        button5.setTitle(String(format:"%d", buttonVals[4]), forState: .Normal)
        button6.setTitle(String(format:"%d", buttonVals[5]), forState: .Normal)
        button7.setTitle(String(format:"%d", buttonVals[6]), forState: .Normal)
        button8.setTitle(String(format:"%d", buttonVals[7]), forState: .Normal)
        button9.setTitle(String(format:"%d", buttonVals[8]), forState: .Normal)
        
        scoreLabel.text = String(format: "Game Over: %d", self.score)
        scoreLabel.textColor = UIColor.redColor()
        gameLabel.text = ""
        //gameLabel.setTextColor(UIColor.redColor())
        self.isPlayable = false
        self.isGameOver = true
        nextTimer = NSTimer.scheduledTimerWithTimeInterval(2.1,
            target: self,
            selector: Selector("doNextStep"),
            userInfo: nil,
            repeats: false)
    }
    
    func shuffle<C: MutableCollectionType where C.Index == Int>(var list: C) -> C {
        let c = list.count
        for i in 0..<(c - 1) {
            let j = Int(arc4random_uniform(UInt32(c - i))) + i
            if i != j {
                swap(&list[i], &list[j])
            }
        }
        return list
    }
    
}
