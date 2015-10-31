//
//  Question.swift
//  CultCat
//
//  Created by Михаил on 31.10.15.
//  Copyright © 2015 Mihail. All rights reserved.
//

import Foundation

class Question {
    var text: String!
    var answers = [String]()
    var time: Double!
    
    init(text: String, answers: [String], time: Double) {
        self.text = text
        self.answers = answers
        self.time = time
    }
    
    func update(time: Double, delegate: SessionDelegate) {
        if self.time == time {
            delegate.showQuestion(self)
        }
        
    }
}