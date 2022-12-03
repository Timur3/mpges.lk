//
//  DateValuFormatter.swift
//  mpges.lk
//
//  Created by Timur on 10.06.2020.
//  Copyright © 2020 ChalimovTimur. All rights reserved.

import Foundation
import Charts

public class DateValueFormatter: NSObject, AxisValueFormatter {
    var datePoints: [Double: Double]?
    var chart: BarLineChartViewBase?
    let months = ["Янв", "Февр", "Март",
                  "Апр", "Май", "Июнь",
                  "Июль", "Авг", "Сент",
                  "Окт", "Нояб", "Дек"]
    
    private let dateFormatter = DateFormatter()

    init(chart: BarLineChartViewBase, datePoints: [Double: Double]) {
        super.init()
        dateFormatter.dateFormat = "yyyy"
        self.chart = chart
        self.datePoints = datePoints
    }

    public func stringForValue(_ value: Double, axis: AxisBase?) -> String {
        let date = datePoints?[value] ?? 0
        let index = Calendar.current.component(.month, from: Date(timeIntervalSince1970: date))
        return "\(months[index-1]) \(dateFormatter.string(from: Date(timeIntervalSince1970: date)))"
    }
}
