//
//  CategoryViewController.swift
//  AnalyzeThis
//
//  Created by Harris, Clifford on 9/21/16.
//  Copyright © 2016 Demo. All rights reserved.
//

import UIKit

class CategoryViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {

    struct Category {
        let id: Int!
        let name: String!
    }
    
    @IBOutlet weak var pickerView: UIPickerView!
    @IBOutlet weak var barView: BarGraphView!
    
    var categories: [Category] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = AT_GRAY
        
        pickerView.delegate = self
        pickerView.dataSource = self
        pickerView.backgroundColor = AT_GRAY
        
        barView.backgroundColor = AT_GRAY

        APIController.fetchCategories(completion: { result in
            if let result = result as? [NSDictionary] {
                for res in result {
                    let catId = res["id"] as! Int
                    let catName = res["name"] as! String
                    let cat = Category(id: catId, name: catName)
                    self.categories.append(cat)
                }
                self.pickerView.reloadAllComponents()
                
                self.fetchCategoryWithId(id: self.categories[0].id)
            }
        })
        
    }
    
    func fetchCategoryWithId(id: Int) {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZ"
        
        var monthlySum: [String: Double] =  [:]
        APIController.fetchTransactionsWithCategoryID(id: id, completion: { result in
            if let result = result as? [NSDictionary] {
                for transaction in result {
                    if let dateString = transaction["txn_date"] as? String {
                        let date = dateFormatter.date(from: dateString)
                        let calender = Calendar(identifier: .gregorian)
                        let month = calender.component(.month, from: date!)
                        let monthName = dateFormatter.shortStandaloneMonthSymbols[month - 1]
                        let amount = transaction["amount"] as! Double
                        
                        if let sum = monthlySum[monthName] {
                            monthlySum[monthName] = sum + amount
                        } else {
                            monthlySum[monthName] = amount
                        }
                    }
                }
                DispatchQueue.main.async {
                    self.redrawGraph(inputData: monthlySum)
                }
            }
        })
    }
    
    func redrawGraph(inputData: [String: Double]) {
        self.barView.setupWithData(inputData: inputData, label: "")
//        self.barView.setNeedsLayout()
//        self.view.setNeedsLayout()
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
     }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return categories.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return categories[row].name
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        fetchCategoryWithId(id: categories[row].id)
    }
}
