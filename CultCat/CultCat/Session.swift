//
//  Session.swift
//  CultCat
//
//  Created by Михаил on 31.10.15.
//  Copyright © 2015 Mihail. All rights reserved.
//

import Foundation
import Parse

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
    
    init(filmId: String) {
        var query = PFQuery(className:"Film")
        let films = try! query.findObjects()
        print(films.count)
        
        let film = try! query.getObjectWithId("gyc1CrRWlP")
        
        for questionId in (film["questions"] as! [String]) {
            query = PFQuery(className: "Question")
            let questionOb = try! query.getObjectWithId(questionId)
            let text = questionOb["text"] as! String!
            let answers = questionOb["answers"] as! [String]
            let time = questionOb["time"] as! Double!
            let q = Question(text: text, answers: answers, time: time)
            q.number = (questionOb["number"] as! Int) - 1
            
            let statisticArray = questionOb["statistic"] as! [Int]?
            var statistic = [Int]()
            for numb in statisticArray! {
                statistic.append(numb)
            }
            q.statistic = statistic
            self.questions.append(q)
        }
        
        for counterId in (film["counters"] as! [String]) {
            query = PFQuery(className: "Counter")
            let counterOb = try! query.getObjectWithId(counterId)
            let name = counterOb["name"] as! String
            
            let timeStrings = counterOb["incrementTimes"] as! [String]?
            var times = [Double]()
            for timeString in timeStrings! {
                let time = Double(timeString)
                times.append(time!)
            }
            
            counters.append(Counter(name: name, times: times))
        }
    }
    
    func startSession() {
        while(true) {
            sleep(UInt32(1))
            currentTime = currentTime + 1
            print(currentTime)
            
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
            
            delegate.updateTime()
        }
    }
    
    func getProgress() -> Float {
        return Float(Double(currentTime) / Double(film.duration!))
    }
}