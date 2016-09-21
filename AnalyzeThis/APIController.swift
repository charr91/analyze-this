//
//  APIController.swift
//  AnalyzeThis
//
//  Created by Harris, Clifford on 9/21/16.
//  Copyright © 2016 Demo. All rights reserved.
//

import Foundation
import Alamofire

class APIController: NSObject {

    static func fetchAllTransactions(completion: @escaping (NSArray) -> Void) {
        Alamofire.request("http://127.0.0.1:3000/transactions").responseJSON { response in
            if let result = response.result.value {
                let json = result as! NSArray
                completion(json)
            }
        }
    }
    
    static func fetchTransactionsWithCategoryID(id: Int, completion: @escaping (NSArray) -> Void) {
        Alamofire.request("http://127.0.0.1:3000/categories/\(id)/transactions").responseJSON { response in
            if let result = response.result.value {
                let json = result as! NSArray
                completion(json)
            }
        }
    }
    
    static func fetchCategories(completion: @escaping (NSArray) -> Void) {
        Alamofire.request("http://127.0.0.1:3000/categories").responseJSON { response in
            if let result = response.result.value {
                let json = result as! NSArray
                completion(json)
            }
        }
    }
    
}
