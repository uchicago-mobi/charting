//
//  SecondViewController.swift
//  Charting
//
//  Created by Chelsea Troy on 4/28/19.
//  Copyright © 2019 Chelsea Troy. All rights reserved.
//

import UIKit
import Charts

class SecondViewController: UIViewController {
    @IBOutlet weak var lineChartView: LineChartView!
    @IBOutlet weak var pieChartView: PieChartView!
    
    var dataEntries: [ChartDataEntry] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let months = ["Jan", "Feb", "Mar", "Apr", "May"]
        let unitsSold = [4.0, 6.0, 3.0, 12.0, 16.0]
        
        self.setChartData(dataPoints: months, values: unitsSold)
        self.setPieChart()
        self.setLineChart()
    }
    
    func setChartData(dataPoints: [String], values: [Double]) {
        for (index, value) in values.enumerated() {
            let dataEntry = ChartDataEntry(
                x: Double(index),
                y: value)
            self.dataEntries.append(dataEntry)
        }
        self.pieChartView.notifyDataSetChanged()
        self.lineChartView.notifyDataSetChanged()
    }
    
    func setLineChart() {
        let dataSet = LineChartDataSet(values: self.dataEntries, label: "Units Sold")
        let lineChartData = LineChartData(dataSet: dataSet)
        
        self.lineChartView.data = lineChartData
        self.lineChartView.animate(xAxisDuration: 1.0, easingOption: .easeInBack)
    }
    
    func setPieChart() {
        let pieChartDataSet = PieChartDataSet(values: self.dataEntries, label: "Units Sold")
        let pieChartData = PieChartData(dataSet:  pieChartDataSet)
        pieChartDataSet.colors = ChartColorTemplates.colorful()
        
        self.pieChartView.data = pieChartData
        self.pieChartView.usePercentValuesEnabled = true
        self.pieChartView.legend.orientation = .vertical
        self.pieChartView.animate(xAxisDuration: 2.0)
    }
}
