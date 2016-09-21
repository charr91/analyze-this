//
//  BarGraphView.swift
//  AnalyzeThis
//
//  Created by Harris, Clifford on 9/21/16.
//  Copyright © 2016 Demo. All rights reserved.
//

import UIKit
import Charts

class BarGraphView: BarChartView {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    func setupWithData(inputData: [String: Double], label: String) {
        drawGridBackgroundEnabled = false
        pinchZoomEnabled = false
        chartDescription?.enabled = false
        drawBarShadowEnabled = false
        drawValueAboveBarEnabled = false
        
//        animate(xAxisDuration: 3000)
        
        var entries: [BarChartDataEntry] = []
        
        var i = 0
        for (_, value) in inputData {
            entries.append(BarChartDataEntry(x: Double(i), y:value))
            i += 1
        } 
        
        let dataSet = BarChartDataSet(values: entries, label: label)
        dataSet.setColors(AT_GREEN, AT_YELLOW, AT_ORANGE, AT_BLUE)
        dataSet.highlightEnabled = false
        
        let data = BarChartData(dataSet: dataSet)
//        data.barWidth = 0.5
        self.data = data
        backgroundColor = AT_GRAY
        setScaleEnabled(false)
        
        legend.enabled = false
        
        let valueFormatter = XAxisStringValueFormatter(values: Array(inputData.keys))
        xAxis.valueFormatter = valueFormatter
        xAxis.granularity = 1
        xAxis.drawGridLinesEnabled = false
        xAxis.drawAxisLineEnabled = false
        xAxis.labelPosition = .bottom
        xAxis.gridLineWidth = 20
        
        let rightAxis = getAxis(.right)
        rightAxis.enabled = false
        
        let leftAxis = getAxis(.left)
        leftAxis.axisMinimum = 0.0
        leftAxis.spaceTop = 5
        leftAxis.drawAxisLineEnabled = false
    }
    
    func updateData(inputData: [String: Double]) {
        
    }
}

