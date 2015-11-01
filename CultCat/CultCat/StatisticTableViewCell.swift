//
//  StatisticTableViewCell.swift
//  CultCat
//
//  Created by Михаил on 01.11.15.
//  Copyright © 2015 Mihail. All rights reserved.
//

import UIKit
import Charts

class StatisticTableViewCell: UITableViewCell {

    @IBOutlet weak var questionLabel: UILabel!
    @IBOutlet weak var chart: PieChartView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setChart(dataPoints: [String], values: [Double]) {
        
        
        var dataEntries: [ChartDataEntry] = []
        
        for i in 0..<dataPoints.count {
            let dataEntry = ChartDataEntry(value: values[i], xIndex: i)
            dataEntries.append(dataEntry)
        }
        
        let chartDataSet = PieChartDataSet(yVals: dataEntries, label: "")
        chartDataSet.colors = ChartColorTemplates.colorful()
        let chartData = PieChartData(xVals: dataPoints, dataSet: chartDataSet)
        chart.data = chartData
        chart.animate(xAxisDuration: 1.5, yAxisDuration: 1.5)
    }

}










