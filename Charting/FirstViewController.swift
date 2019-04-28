//
//  FirstViewController.swift
//  Charting
//
//  Created by Chelsea Troy on 4/28/19.
//  Copyright © 2019 Chelsea Troy. All rights reserved.
//
// Chart Implementation Inspired by https://www.appcoda.com/ios-charts-api-tutorial/

import UIKit
import Charts

class FirstViewController: UIViewController, ChartViewDelegate {
    @IBOutlet weak var barChartView: BarChartView!
    
    var months = ["Jan", "Feb", "Mar", "Apr", "May", "Jun", "Jul", "Aug", "Sep", "Oct", "Nov", "Dec"]
    let target = 7.0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let unitsSold = [20.0, 4.0, 6.0, 3.0, 12.0, 16.0, 4.0, 18.0, 2.0, 4.0, 5.0, 4.0]
        
        self.barChartView.delegate = self
        self.setChartData(dataPoints: months, values: unitsSold)
        self.setBarChart()
    }
    
    func setChartData(dataPoints: [String], values: [Double]) {
        var dataEntries: [BarChartDataEntry] = []
        var performanceColors: [UIColor] = []
        
        func performanceColor(for value: Double) -> UIColor {
            switch value {
            case 0...self.target * 0.5:
                return UIColor.red
            case self.target * 0.4...self.target * 0.65:
                return UIColor.orange
            case self.target * 0.65...self.target:
                return UIColor.yellow
            case self.target...:
                return UIColor.green
            default:
                fatalError("Invalid value")
            }
        }
        
        for (index, value) in values.enumerated() {
            let dataEntry = BarChartDataEntry(x: Double(index), y: value)
            dataEntries.append(dataEntry)
            performanceColors.append(performanceColor(for: value))
        }
        
        let chartDataSet = BarChartDataSet(values: dataEntries, label: "Units Sold")
        chartDataSet.colors = performanceColors
        let chartData = BarChartData(dataSet: chartDataSet)
        self.barChartView.data = chartData
        self.barChartView.notifyDataSetChanged()
    }
    
    func setBarChart() {
        self.barChartView.noDataText = "Data Unavailable"

        self.barChartView.backgroundColor = UIColor.white
        
        self.barChartView.xAxis.labelPosition = .bottom
        self.barChartView.animate(xAxisDuration: 2.0, yAxisDuration: 2.0)
        
        let limitLine = ChartLimitLine(limit: self.target, label: "Target")
        self.barChartView.rightAxis.addLimitLine(limitLine)
        self.barChartView.xAxis.valueFormatter = IndexAxisValueFormatter(values: self.months)
    }
    
    //MARK: ChartViewDelegate Methods
    
    func chartValueSelected(chartView: ChartViewBase, entry: ChartDataEntry, dataSetIndex: Int, highlight: Highlight) {
    }


}

