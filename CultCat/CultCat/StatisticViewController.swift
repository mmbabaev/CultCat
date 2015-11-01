//
//  StatisticViewController.swift
//  CultCat
//
//  Created by Михаил on 01.11.15.
//  Copyright © 2015 Mihail. All rights reserved.
//

import UIKit
import Charts

class StatisticViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    var chart: PieChartView!
    var session: Session!
    var questions: [Question]!
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        questions = session.questions
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return questions.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("pieCell") as! StatisticTableViewCell
        let question = questions[indexPath.row]
        
        cell.questionLabel.text = question.text
        var values = [Double]()
        for numb in question.statistic {
            values.append(Double(numb))
        }
        cell.setChart(question.answers, values: values)
        
        return cell
    }
    
    
}
