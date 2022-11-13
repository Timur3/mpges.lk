//
//  String+Extension.swift
//  mpges.lk
//
//  Created by Timur on 10.11.2022.
//  Copyright © 2022 ChalimovTimur. All rights reserved.
//

import Foundation

extension String {
    
    func fromBase64() -> String? {
        guard let data = Data(base64Encoded: self) else {
            return nil
        }
        
        return String(data: data, encoding: .utf8)
    }
    
    func toBase64() -> String {
        return Data(self.utf8).base64EncodedString()
    }
    
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
