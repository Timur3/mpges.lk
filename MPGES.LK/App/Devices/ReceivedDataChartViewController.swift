//
//  ReceivedDataChartViewController.swift
//  mpges.lk
//
//  Created by Timur on 08.06.2020.
//  Copyright © 2020 ChalimovTimur. All rights reserved.
//

import UIKit
import Charts

public protocol ReceivedDataChartViewControllerDelegate: AnyObject {
    func setData(model: ResultModel<[ReceivedDataVolumeModel]>)
}

class ReceivedDataChartViewController: UIViewController, ChartViewDelegate {

    public weak var delegate: DeviceCoordinatorMain?
    
    public var device: DeviceModel? {
        didSet {
            refreshReceivedData()
        }
    }
    
    @objc func refreshReceivedData(){
        ApiServiceWrapper.shared.getReceivedDataVolumeByDeviceId(id: device!.id, delegate: self)
    }
    
    var chartView = BarChartView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = .systemGroupedBackground
        guard let safeArea = self.navigationController?.view.safeAreaLayoutGuide.layoutFrame else { return }
        chartView.frame = CGRect(x: self.view.safeAreaInsets.left, y: self.view.safeAreaInsets.top, width: safeArea.width, height: safeArea.height - 150)
        
        chartView.center = self.view.center
        view.addSubview(chartView)
             
        chartView.delegate = self
        
        chartView.drawBarShadowEnabled = false
        chartView.drawValueAboveBarEnabled = true
        chartView.borderLineWidth = 1
        chartView.maxVisibleCount = 10000
    }
    
    func setChart(_ count: Int, data: [BarChartDataEntry], datePoints: [Double: Double], minXValue: Double, maxXValue: Double) {
        let xAxis = chartView.xAxis
        xAxis.labelPosition = .bottom
        xAxis.labelFont = .systemFont(ofSize: 10)
        xAxis.drawAxisLineEnabled = false
        xAxis.granularity = 1
        xAxis.labelCount = 7
        xAxis.valueFormatter = DateValueFormatter(chart: chartView, datePoints: datePoints)
        
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
        l.font = .systemFont(ofSize: 11)
        l.xEntrySpace = 4

        let marker = XYMarkerView(color: UIColor(white: 180/250, alpha: 1),
                                  font: .systemFont(ofSize: 12),
                                  textColor: .white,
                                  insets: UIEdgeInsets(top: 8, left: 8, bottom: 20, right: 8),
                                  xAxisValueFormatter: chartView.xAxis.valueFormatter!)
        marker.chartView = chartView
        marker.minimumSize = CGSize(width: 80, height: 40)
        chartView.marker = marker
        
        chartView.fitBars = true
        
        chartView.animate(yAxisDuration: 2.5)
        
        let yVals: [BarChartDataEntry] = data
        let set1 = BarChartDataSet(entries: yVals, label: "Потребленный объем в кВт*ч")
        set1.drawIconsEnabled = false
        set1.barBorderColor = .systemBlue
        
        let data1 = BarChartData(dataSet: set1)
        data1.setValueFont(.systemFont(ofSize: 10))
        
        chartView.data = data1
    }
}

extension ReceivedDataChartViewController: ReceivedDataChartViewControllerDelegate {
    func setData(model: ResultModel<[ReceivedDataVolumeModel]>) {
        var datePoints: [Double: Double] = [:]
        guard let data = model.data?.sorted(by: { $0.unixDate < $1.unixDate }) else { return }
        
        let minValue = data.map { $0.unixDate }.min()
        let maxValue = data.map { $0.unixDate }.max()
        
        let d = (0 ..< data.count).map { (i) -> BarChartDataEntry in
            datePoints[Double(i)] = Double(data[i].unixDate)
            return BarChartDataEntry (x: Double(i), y: Double(data[i].volume))
        }
        self.setChart(d.count, data: d, datePoints: datePoints, minXValue: Double(minValue ?? 0), maxXValue: Double(maxValue ?? 0))
    }
}
