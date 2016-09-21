//
//  AllViewController.swift
//  AnalyzeThis
//
//  Created by Harris, Clifford on 9/21/16.
//  Copyright © 2016 Demo. All rights reserved.
//

import UIKit

class AllViewController: UIViewController {

    @IBOutlet weak var barView: BarGraphView!
    
    var transactions: [NSDictionary] = []
    var monthlySums: [String: Double] = [:]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = AT_GRAY
        
        APIController.fetchAllTransactions(completion: { result in
            if let result = result as? [NSDictionary] {
                DispatchQueue.main.async {
                    self.transactions = result
                    self.getDates()
                    self.barView.setupWithData(inputData: self.monthlySums, label: "Test")
                }
            }
        })
        
    }
    
    func getDates() {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZ"
        
        for transaction in transactions {
            if let dateString = transaction["txn_date"] as? String {
                let date = dateFormatter.date(from: dateString)
                let calender = Calendar(identifier: .gregorian)
                let month = calender.component(.month, from: date!)
                let monthName = dateFormatter.shortStandaloneMonthSymbols[month - 1]
                
                let amount = transaction["amount"] as! Double
                
                if let sum = monthlySums[monthName] {
                    monthlySums[monthName] = sum + amount
                } else {
                    monthlySums[monthName] = amount
                }
            }
        }
    }

}
