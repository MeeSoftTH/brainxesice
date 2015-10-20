//
//  Question.swift
//  brainexecise
//
//  Created by Petch Temeeyasen on 5/20/15.
//  Copyright (c) 2015 meesoft. All rights reserved.
//

class Question {
    var text: String!
    
    var choice1: String! // choice1 always answer
    var choice2: String!
    
    required init(text: String, choice1: String, choice2: String){
        self.text = text
        self.choice1 = choice1
        self.choice2 = choice2
    }
}