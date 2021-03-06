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

extension String {
   /* func dateNormal() -> String {
        let dateFmt = DateFormatter()
        dateFmt.timeZone = NSTimeZone.default
        dateFmt.dateFormat =  "yyyy-MM-dd"
        let date = dateFmt.date(from: self.replacingOccurrences(of: "T00:00:00", with: ""))
        
        let dayTimePeriodFormatter = DateFormatter()
        dayTimePeriodFormatter.dateFormat = "dd.MM.yyyy"
        let dateString = dayTimePeriodFormatter.string(from: date!)
        return dateString
    }*/
}

func getYear(dateStr: String) -> Int {
    let dateFmt = DateFormatter()
    dateFmt.timeZone = NSTimeZone.default
    dateFmt.dateFormat =  "dd.MM.yyyy"
    let date = dateFmt.date(from: dateStr)
    return Calendar.current.component(.year, from: date!)
}

func getCurrentYear() -> Int {
    return Calendar.current.component(.year, from: Date())
}

func formatRusDate(for date: Date) -> String {
    let formatter = DateFormatter()
    formatter.locale = Locale(identifier: "ru_RU")
    formatter.dateStyle = .short
    
    return formatter.string(from: date)
}
