//
//  Session.swift
//  CultCat
//
//  Created by Михаил on 31.10.15.
//  Copyright © 2015 Mihail. All rights reserved.
//

import Foundation

protocol SessionDelegate {
    func updateTime()
    func updateCounters()
    func showQuestion(question: Question)
    func sessionWasEnd()
}

class Session {
    var delegate: SessionDelegate!
    var film: Film!

    var currentTime = 0.0
    var counters = [Counter]()
    var questions = [Question]()
    
    func startSession() {
        while(true) {
            sleep(6000 * 60)
            currentTime = currentTime + 0.1
            
            if (currentTime == film.duration) {
                delegate.sessionWasEnd()
                break;
            }
            
            for counter in counters {
                counter.update(currentTime, delegate: delegate)
            }
            
            for question in questions {
                question.update(currentTime, delegate: delegate)
            }
        }
    }
}