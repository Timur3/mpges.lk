//
//  XYMarkerView.swift
//  mpges.lk
//
//  Created by Timur on 19.11.2022.
//  Copyright © 2022 ChalimovTimur. All rights reserved.
//

import Foundation
import Charts
#if canImport(UIKit)
    import UIKit
#endif

public class XYMarkerView: BalloonMarker {
    public var xAxisValueFormatter: AxisValueFormatter
    fileprivate var yFormatter = NumberFormatter()
    
    public init(color: UIColor, font: UIFont, textColor: UIColor, insets: UIEdgeInsets,
                xAxisValueFormatter: AxisValueFormatter) {
        self.xAxisValueFormatter = xAxisValueFormatter
        yFormatter.minimumFractionDigits = 1
        yFormatter.maximumFractionDigits = 1
        super.init(color: color, font: font, textColor: textColor, insets: insets)
    }
    
    public override func refreshContent(entry: ChartDataEntry, highlight: Highlight) {
        let string = xAxisValueFormatter.stringForValue(entry.x, axis: XAxis())
            + " - "
            + yFormatter.string(from: NSNumber(floatLiteral: entry.y))!
            + " кВт*ч"
        setLabel(string)
    }
    
}
