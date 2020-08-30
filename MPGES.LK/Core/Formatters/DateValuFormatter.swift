//
//  DateValuFormatter.swift
//  mpges.lk
//
//  Created by Timur on 10.06.2020.
//  Copyright © 2020 ChalimovTimur. All rights reserved.

import Foundation
import Charts

public class DateValueFormatter: NSObject, IAxisValueFormatter {
    private let dateFormatter = DateFormatter()
    
    override init() {
        super.init()
        dateFormatter.dateFormat = "MM-yyyy"
    }
    
    public func stringForValue(_ value: Double, axis: AxisBase?) -> String {
        let date = Date()
        let formatter = DateFormatter()
        formatter.dateFormat = "dd.MM.yyyy"

        //let result = formatter.string(from: date)
        
        return dateFormatter.string(from: Date(timeIntervalSince1970: value))
    }
}
