//
//  DateHelper.swift
//  mpges.lk
//
//  Created by Timur on 19.01.2020.
//  Copyright © 2020 ChalimovTimur. All rights reserved.
//

import Foundation

func UnixTimeToDateTime(unixtime: Int, fullFormat: Bool = false) -> String {
    let date = NSDate(timeIntervalSince1970: Double(unixtime))
        
    let dayTimePeriodFormatter = DateFormatter()
    if (fullFormat) {
        dayTimePeriodFormatter.dateFormat = "dd.MM.yyyy hh:mm"
    } else {
        dayTimePeriodFormatter.dateFormat = "dd.MM.yyyy"
    }
    let dateString = dayTimePeriodFormatter.string(from: date as Date)
    return dateString
}

func DateNormal(dateS: String) -> String {
    let dateFmt = DateFormatter()
    dateFmt.timeZone = NSTimeZone.default
    dateFmt.dateFormat =  "yyyy-MM-dd"
    let date = dateFmt.date(from: dateS)
    
    let dayTimePeriodFormatter = DateFormatter()
    dayTimePeriodFormatter.dateFormat = "dd.MM.yyyy"
    let dateString = dayTimePeriodFormatter.string(from: date!)
    return dateString
}
