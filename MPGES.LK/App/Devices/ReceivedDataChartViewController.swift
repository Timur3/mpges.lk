//
//  ReceivedDataChartViewController.swift
//  mpges.lk
//
//  Created by Timur on 08.06.2020.
//  Copyright © 2020 ChalimovTimur. All rights reserved.
//

import UIKit
import Charts

class ReceivedDataChartViewController: UIViewController, ChartViewDelegate {
    
    var chartView = BarChartView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = .systemGroupedBackground
        //let window = UIWindow(frame: self.view.frame)
        let safeArea = self.view.safeAreaLayoutGuide.layoutFrame
        chartView.frame = CGRect(x: self.view.safeAreaInsets.left, y: self.view.safeAreaInsets.top, width: safeArea.width, height: safeArea.height - 150)
        chartView.center = self.view.center
        self.view.addSubview(chartView)
        // Do any additional setup after loading the view.
        //self.title = "Horizontal Bar Char"

        chartView.delegate = self
        
        chartView.drawBarShadowEnabled = false
        chartView.drawValueAboveBarEnabled = true
        
        chartView.maxVisibleCount = 60
        
        let xAxis = chartView.xAxis
        xAxis.labelPosition = .bottom
        xAxis.labelFont = .systemFont(ofSize: 10)
        xAxis.drawAxisLineEnabled = true
        xAxis.granularity = 2
        xAxis.valueFormatter = DateValueFormatter()
        
        let leftAxis = chartView.leftAxis
        leftAxis.labelFont = .systemFont(ofSize: 10)
        leftAxis.drawAxisLineEnabled = true
        leftAxis.drawGridLinesEnabled = true
        leftAxis.axisMinimum = 0
        
        let rightAxis = chartView.rightAxis
        rightAxis.enabled = true
        rightAxis.labelFont = .systemFont(ofSize: 10)
        rightAxis.drawAxisLineEnabled = true
        rightAxis.axisMinimum = 0
        
        let l = chartView.legend
        l.horizontalAlignment = .left
        l.verticalAlignment = .bottom
        l.orientation = .horizontal
        l.drawInside = false
        l.form = .square
        l.formSize = 8
        l.font = UIFont(name: "HelveticaNeue-Light", size: 11)!
        l.xEntrySpace = 4
      
        chartView.fitBars = true
        chartView.animate(yAxisDuration: 2.5)
        
        self.updateChartData()
    }
    
    func updateChartData() {
        self.setDataCount(Int(12), range: UInt32(1000))
    }
    
    func setDataCount(_ count: Int, range: UInt32) {
        let barWidth = 4.0
        let spaceForBar = 10.0
        
        let yVals = (0..<count).map { (i) -> BarChartDataEntry in
            let mult = range + 1
            let val = Double(arc4random_uniform(mult))
            return BarChartDataEntry(x: Double(i)*spaceForBar, y: val)
        }
        
        let set1 = BarChartDataSet(entries: yVals, label: "Потребленный объем в кВт*ч в месяц")
        set1.drawIconsEnabled = false
        
        let data = BarChartData(dataSet: set1)
        data.setValueFont(UIFont(name:"HelveticaNeue-Light", size:10)!)
        data.barWidth = barWidth
        
        chartView.data = data
    }
}
