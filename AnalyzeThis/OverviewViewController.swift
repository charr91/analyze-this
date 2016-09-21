//
//  OverviewViewController.swift
//  AnalyzeThis
//
//  Created by Harris, Clifford on 9/21/16.
//  Copyright © 2016 Demo. All rights reserved.
//

import UIKit
import Charts

class OverviewViewController: UIViewController {

    @IBOutlet var pieChartView: PieChartView!
    
    var transactions: [NSDictionary] = []
    var categoryMap: [String: Float] = [:]
    var entries: [PieChartDataEntry] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = AT_GRAY
        
        APIController.fetchAllTransactions(completion: { result in
            print(result)
            if let result = result as? [NSDictionary] {
                self.transactions = result
                self.mapCategories()
                self.displayGraph()
            }
        })
    }
    
    func displayGraph() {
        for (category, value) in categoryMap {
            entries.append(PieChartDataEntry(value: Double(value) / 100, label: category))
        }
        
        let dataSet = PieChartDataSet(values: entries, label: "Results")
        dataSet.sliceSpace = 5.0
        dataSet.setColors(AT_GREEN, AT_YELLOW, AT_ORANGE, AT_BLUE)
        dataSet.valueTextColor = UIColor.black
        
        let data = PieChartData(dataSet: dataSet)
        pieChartView.data = data
        pieChartView.backgroundColor = AT_GRAY
        pieChartView.centerText = "Spending Overview"
        
        let legend = pieChartView.legend
        legend.enabled = false
    }
    
    func mapCategories() {
        for transaction in transactions {
            let merchant = transaction["merchant"] as! NSDictionary
            let cat = merchant["category"] as! NSDictionary
            let catName = cat["name"] as! String
            let amount = transaction["amount"] as! Float
            
            if let amt = categoryMap[catName] {
                categoryMap[catName] = amt + amount
            } else {
                categoryMap[catName] = amount
            }
        }
    }
}
