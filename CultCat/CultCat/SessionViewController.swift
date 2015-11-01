//
//  SessionViewController.swift
//  CultCat
//
//  Created by Михаил on 31.10.15.
//  Copyright © 2015 Mihail. All rights reserved.
//

import UIKit

class SessionViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, SessionDelegate, UIAlertViewDelegate {
    @IBOutlet weak var progressBar: UIProgressView!
    
    @IBOutlet weak var tableView: UITableView!
    
    var filmId: String! = "test"
    var film: Film!
    var session: Session!
    var questionCount = 0
    
    @IBOutlet weak var questionsView: UIView!
    
    var flags = [UIView]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = film.name
        
        session = Session(filmId: filmId)
        session.film = film
        session.delegate = self
        
        for question in session.questions {
            let pX = Double(question.time) / Double(film.duration!)

            let x = questionsView.frame.size.width * CGFloat(pX)
            let rect = CGRect(x: x + 3, y: 0, width: 6, height: questionsView.frame.size.height)
            
            let flag = UIView(frame: rect)
            flag.backgroundColor = UIColor.grayColor()
            flags.append(flag)
            questionsView.addSubview(flag)
        }
        
        let qualityOfServiceClass = QOS_CLASS_BACKGROUND
        let backgroundQueue = dispatch_get_global_queue(qualityOfServiceClass, 0)
        dispatch_async(backgroundQueue, {
            self.session.startSession()
        })
    }

    func startSession() {
        session.startSession()
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("counterCell") as! CounterTableViewCell
        let counter = session.counters[indexPath.row]
        cell.nameLabel.text = counter.name
        cell.countLabel.text = String(counter.currentCount)
        
        return cell
    }
    
    @IBOutlet weak var progressLabel: UILabel!
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return session.counters.count
    }
    
    func updateTime() {
        dispatch_async(dispatch_get_main_queue()) {
            print(self.session.getProgress())
            self.progressLabel.text = String(self.session.getProgress())
            self.progressBar.setProgress(Float(self.session.getProgress()), animated: true)
            self.tableView.reloadData()
        }
    }
    
    func updateCounters() {
        dispatch_async(dispatch_get_main_queue()) {
            self.tableView.reloadData()
        }
    }
    
    func showQuestion(question: Question) {
        questionCount = questionCount + 1
        
        let title = "Вопрос номер " + String(questionCount) + ":"
        let alert = UIAlertController(title: title, message: question.text, preferredStyle: .Alert)
        
        for answer in question.answers {
            
            let action = UIAlertAction(title: answer, style: .Default) { _ in
                self.addAnswer(answer, forQuestion: question)
                dispatch_async(dispatch_get_main_queue()) {
                    self.flags[question.number].backgroundColor = UIColor.blueColor()
                }
            }

            alert.addAction(action)
        }
        
        dispatch_async(dispatch_get_main_queue()) {
            self.presentViewController(alert, animated: true){}
        }
    }
    
    func addAnswer(answer: String, forQuestion: Question) {
        
        print("add " + answer)
    }
    
    func sessionWasEnd() {
        updateTime()
        print("session end")
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "end" {
            let vc = segue.destinationViewController as! StatisticViewController
            vc.session = session
        }
    }

    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */


}
