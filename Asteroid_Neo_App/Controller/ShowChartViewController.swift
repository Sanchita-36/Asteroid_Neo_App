//
//  ShowChartViewController.swift
//  Asteroid_Neo_App
//
//  Created by Mac on 10/07/21.
//  Copyright © 2021 Sanchita. All rights reserved.
//

import UIKit
import Charts

class ShowChartViewController: UIViewController {
    
    @IBOutlet weak var chartsView: UIView!
    var dateArray_ShowCharts: [String] = []
    var asteroidCountArray_ShowCharts: [Int] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        makeChart(dataPoints: dateArray_ShowCharts, values: asteroidCountArray_ShowCharts.map{ Int($0) })
    }
    
    func makeChart(dataPoints: [String], values: [Int]) {
        let barChart = BarChartView(frame: CGRect(x: 0, y: 0, width: chartsView.frame.size.width, height: chartsView.frame.size.height))
        
        var dataEntries: [BarChartDataEntry] = []
        for i in 0..<dataPoints.count {
            let dataEntry = BarChartDataEntry(x: Double(i), y: Double(values[i]))
            dataEntries.append(dataEntry)
        }
        let chartDataSet = BarChartDataSet(entries: dataEntries, label: "Total Asteroid Number")
        let chartData = BarChartData(dataSet: chartDataSet)
        barChart.data = chartData
       // barChart.center = view.center
        chartsView.addSubview(barChart)
        
    }

    @IBAction func crossOut(_ sender: UIButton) {
        let vc = self.storyboard?.instantiateViewController(identifier: "ViewController") as! ViewController
        self.navigationController?.pushViewController(vc, animated: true)
    }
}
