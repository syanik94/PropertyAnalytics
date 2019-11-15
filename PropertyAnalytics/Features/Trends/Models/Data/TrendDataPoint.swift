//
//  TrendDataPoint.swift
//  PropertyAnalytics
//
//  Created by Yanik Simpson on 11/14/19.
//  Copyright © 2019 Yanik Simpson. All rights reserved.
//

import Foundation

struct TrendDataPoint {
    let date: String
    let value: Double
    
    init(dateString: String, value: Double) {
        self.date = dateString
        self.value = value
    }
}

struct StateTrendViewModel {
    let state: String
    var dataPoints: [TrendDataPoint]
    
    init(state: String, dictionary: [String: [String: Double]]) {
        self.state = state
        self.dataPoints = []
        
        dictionary.keys.forEach { (key) in
            dictionary[key]?.keys.forEach({ (nestedKey) in
                dataPoints.append(TrendDataPoint(
                    dateString: nestedKey,
                    value: dictionary[key]![nestedKey]!))
            })
        }
        sortDataPoints()
    }
    
    mutating func sortDataPoints() {
        dataPoints.sort { (stateTrend1, stateTrend2) -> Bool in
            if let stateTrendDate1 = stateTrend1.date.getDate() {
                if let stateTrendDate2 = stateTrend2.date.getDate() {
                    return stateTrendDate1 < stateTrendDate2
                }
            }
            return true
        }
    }
}

