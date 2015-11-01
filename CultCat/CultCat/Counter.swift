//
//  Counter.swift
//  CultCat
//
//  Created by Михаил on 31.10.15.
//  Copyright © 2015 Mihail. All rights reserved.
//

import Foundation

class Counter {
    var name: String!
    var incrementTime = [Double]()
    var currentCount = 0.0
    
    init(name: String, times: [Double]) {
        self.name = name
        incrementTime = times
    }
    
    func update(time: Double, delegate: SessionDelegate) {
        if incrementTime.contains(time) {
            currentCount = currentCount + 1
            delegate.updateCounters()
        }
    }
}